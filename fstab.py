from pathlib import Path
from tempfile import NamedTemporaryFile

from box import Box, BoxList
from fire import Fire
from pydumpling import catch_any_exception
from plumbum.cmd import cp, sudo

catch_any_exception()


class Fstab:
    def __init__(
        self,
        fstab_path: str | Path | None = '/etc/fstab',
        fstab_dir: str | Path | None = None,
    ):
        if not (fstab_path or fstab_dir):
            msg = 'Either fstab_path or fstab_dir must be provided'
            raise ValueError(msg)

        self.fstabs = BoxList()

        if fstab_path:
            self.fstab_path = Path(fstab_path).expanduser().resolve()
            if not self.fstab_path.exists():
                msg = f'fstab_path {self.fstab_path} does not exist'
                raise FileNotFoundError(msg)

            self.fstabs.append(self.read_fstab(self.fstab_path))

        if fstab_dir:
            self.fstab_dir = Path(fstab_dir).expanduser().resolve()
            if not self.fstab_dir.exists():
                msg = f'fstab_dir {self.fstab_dir} does not exist'
                raise FileNotFoundError(msg)

            for file in self.fstab_dir.iterdir():
                if file.is_file():
                    self.fstabs.append(self.read_fstab(file))

        # 进行去重
        self.deduplicate()

    def deduplicate(self):
        global_table = set()
        fstabs = self.fstabs.copy()

        for fstab in fstabs:
            fstab_table = []
            for row in fstab.table:
                row = tuple(row)
                if row not in global_table:
                    global_table.add(row)
                    fstab_table.append(row)
            fstab.table = fstab_table

    def read_fstab(self, fstab_path: str | Path):
        fstab_path = Path(fstab_path).expanduser().resolve()
        if not fstab_path.exists():
            msg = f'fstab_path {fstab_path} does not exist'
            raise FileNotFoundError(msg)

        with open(fstab_path) as f:
            fstab = f.readlines()

        comments = []
        table = []

        for line in fstab:
            line = line.strip()
            if not line or line.startswith('#'):
                comments.append(line)
            else:
                table.append(line.split())

        fstab = {'comments': comments, 'table': table}
        return Box(fstab)

    def write_fstab(
        self,
        fstab_path: str | Path = './fstab',
        *,
        should_backup=True,
        should_sudo=True,
    ):
        fstab_path = Path(fstab_path).expanduser().resolve()
        fstab_path.parent.mkdir(parents=True, exist_ok=True)

        with NamedTemporaryFile('w', delete=False) as f:
            print(self, file=f)
            temp_fstab_path = Path(f.name)

        backup_arg = '--backup=t' if should_backup else ''
        cmd = cp['-a', backup_arg, temp_fstab_path, fstab_path]

        if should_sudo:
            cmd = sudo[cmd]

        print(cmd)

        # 运行命令
        cmd()

        # 删除临时文件
        temp_fstab_path.unlink(missing_ok=True)

    @staticmethod
    def pretty_table(table):
        # 每列的最小宽度
        min_widths = [43, 15, 6, 28, 1, 1]

        # 给第一行加上一个哑字段，用于指示每个字段是什么
        # fstab_header = (
        #     "#<file system> <mount point> <type> <options> <dump> <pass>".split()
        # )

        lines = []
        # lines.append(" ".join(fstab_header))

        for row in table:
            fstab_row = []

            for idx, field in enumerate(row):
                fstab_row.append(f'{field:<{min_widths[idx]}}')

            fstab_row = ' '.join(fstab_row)

            lines.append(fstab_row)

        return '\n'.join(lines)

    def __str__(self):
        fstab_strs = []
        for fstab in self.fstabs:
            comments_str = '\n'.join(fstab.comments)
            table_str = self.pretty_table(fstab.table)
            fstab_str = f'{comments_str}\n{table_str}'
            fstab_strs.append(fstab_str)
        fstabs_str = '\n'.join(fstab_strs)
        return fstabs_str


if __name__ == '__main__':
    Fire(Fstab)
