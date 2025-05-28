# %%
from __future__ import annotations

import os
from pathlib import Path
import platform
import tempfile

from box import Box
from fire import Fire
from dotenv import load_dotenv
from loguru import logger
from pydumpling import catch_any_exception
from plumbum.cmd import mv, sudo

# %%
catch_any_exception()
load_dotenv()


# %%
class ThirdPartySources:
    def __init__(
        self,
        *,
        node_major: str = os.environ.get('NODE_MAJOR', '22'),
        keyrings_path: str | Path = '/etc/apt/keyrings',
    ):
        # %%
        # 获取系统信息
        os_release = Box(platform.freedesktop_os_release())
        version_id = os_release.VERSION_ID
        version_codename = os_release.VERSION_CODENAME

        # %%
        self.sources = {
            'github-cli': 'deb [arch=amd64 signed-by={}] https://cli.github.com/packages stable main',
            # "ueberzugpp": f"deb [signed-by={{}}] http://download.opensuse.org/repositories/home:/justkidding/xUbuntu_{version_id}/ /",
            'docker-ctop': 'deb [arch=amd64 signed-by={}] http://packages.azlux.fr/debian stable main',
            'docker-ce': f'deb [arch=amd64 signed-by={{}}] https://repo.huaweicloud.com/docker-ce/linux/ubuntu {version_codename} stable',
            'caddy': 'deb [signed-by={}] https://dl.cloudsmith.io/public/caddy/stable/deb/debian any-version main',
            'xcaddy': 'deb [signed-by={}] https://dl.cloudsmith.io/public/caddy/xcaddy/deb/debian any-version main',
            # "hashicorp": f"deb [arch=amd64 signed-by={{}}] https://apt.releases.hashicorp.com {version_codename} main",
            # "mise": "deb [signed-by={} arch=amd64] https://mise.jdx.dev/deb stable main",
            'nodejs': f'deb [arch=amd64 signed-by={{}}] https://deb.nodesource.com/node_{node_major}.x nodistro main',
            'postgresql': f'deb [signed-by={{}}] https://mirrors.aliyun.com/postgresql/repos/apt {version_codename}-pgdg main',
            'xpipe': 'deb [signed-by={}] https://apt.xpipe.io/ stable main',
            # 'windsurf': 'deb [signed-by={} arch=amd64] https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/apt stable main',
            'winehq': f'deb [arch=amd64,i386 signed-by={{}}] http://mirrors.tuna.tsinghua.edu.cn/wine-builds/ubuntu/ {version_codename} main',
            'waydroid': f'deb [signed-by={{}}] https://repo.waydro.id/ {version_codename} main',
            'zotero': 'deb [arch=amd64 signed-by={}] https://zotero.retorque.re/file/apt-package-archive ./',
            'onlyoffice': 'deb [signed-by={}] https://download.onlyoffice.com/repo/debian squeeze main',
            # "nvidia-container": "deb [signed-by={}] https://nvidia.github.io/libnvidia-container/stable/deb/$(ARCH) /",
            # "fpf-apt-tools": f"deb [signed-by={{}}] https://packages.freedom.press/apt-tools-prod {version_codename} main",
            'stripe': 'deb [signed-by={}] https://packages.stripe.dev/stripe-cli-debian-local stable main',
            'ngrok': 'deb [signed-by={}] https://ngrok-agent.s3.amazonaws.com buster main',
            'goaccess': f'deb [arch=amd64 signed-by={{}}] https://deb.goaccess.io/ {version_codename} main',
            'grafana': 'deb [signed-by={}] https://mirrors.aliyun.com/grafana/debian stable main',
        }

        self.keyrings_path = Path(keyrings_path).expanduser().resolve()
        for k, v in self.sources.items():
            self.sources[k] = v.format(self.keyrings_path / f'{k}.gpg')

    def add_sources(self):
        sources_path = Path('/etc/apt/sources.list.d')
        tmp_path = Path(tempfile.gettempdir()).resolve()

        for name, url in self.sources.items():
            # 将源添加到临时文件夹，然后移动到 sources.list.d 文件夹
            tmp_source_path = tmp_path / f'{name}.list'
            tmp_source_path.write_text(url + '\n')

            # 移动到 sources.list.d 文件夹
            sudo[mv[tmp_source_path, sources_path / f'{name}.list']]()

            logger.info(f'Add {name} source to {sources_path / f"{name}.list"}')


# %%
if __name__ == '__main__':
    Fire(ThirdPartySources)
