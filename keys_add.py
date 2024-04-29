# %%
import os
from pathlib import Path
import platform
from pprint import pprint
import sys
import tempfile
from typing import Iterable

from box import Box, BoxList
import einops as ein
import fire
import httpx
from loguru import logger
from matplotlib import pyplot as plt
import pendulum
from plumbum import local
from plumbum.cmd import gpg, sudo
from rich import progress


# %%
class GpgKeys:
    def __init__(
        self,
        client: httpx.Client = None,
        *,
        keyrings_path: str | Path = "/etc/apt/keyrings",
        proxy: str = os.environ.get("http_proxy", "socks5://localhost:1080"),
    ):
        # %%
        # 获取系统信息
        os_release = Box(platform.freedesktop_os_release())
        version_id = os_release.VERSION_ID

        # %%
        self.keys_url = {
            "github-cli": "https://cli.github.com/packages/githubcli-archive-keyring.gpg",
            "ueberzugpp": f"https://download.opensuse.org/repositories/home:justkidding/xUbuntu_{version_id}/Release.key",
            "docker-ctop": "https://azlux.fr/repo.gpg.key",
            "docker-ce-163": "http://mirrors.163.com/docker-ce/linux/ubuntu/gpg",
            "caddy": "https://dl.cloudsmith.io/public/caddy/stable/gpg.key",
            "hashicorp": "https://apt.releases.hashicorp.com/gpg",
            "mise": "https://mise.jdx.dev/gpg-key.pub",
            "nodejs": "https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key",
            "dvc": "https://dvc.org/deb/iterative.asc",
            "winehq": "https://dl.winehq.org/wine-builds/winehq.key",
            "zotero": "https://raw.githubusercontent.com/retorquere/zotero-deb/master/zotero-archive-keyring.gpg",
            "onlyoffice": "https://download.onlyoffice.com/GPG-KEY-ONLYOFFICE",
            "nvidia-container": "https://nvidia.github.io/libnvidia-container/gpgkey",
        }
        self.keys_hash = [
            {
                "name": "fpf-apt-tools",
                "keyserver": "hkps://keys.openpgp.org",
                "key_hash": "DE28 AB24 1FA4 8260 FAC9 B8BA A7C9 B385 2260 4281",
            }
        ]

        self.keyrings_path = Path(keyrings_path).expanduser().resolve()
        self.keyrings_path.mkdir(parents=True, exist_ok=True)
        self.proxy = proxy

        if client is None:
            self.client = httpx.Client(
                headers={
                    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36"
                },
                proxy=proxy,
                follow_redirects=True,
                http2=True,
            )

    def import_keys(self):
        self.download_urls()
        self.recv_keys()

    def download_urls(self):
        tmp_path = Path(tempfile.gettempdir()).resolve()

        for key, url in progress.track(
            self.keys_url.items(),
            description="install keyrings",
            transient=True,
            disable=sys.gettrace() is not None,
        ):
            logger.info(f"Importing {key} keyring...")

            # 临时存储密钥文件
            tmp_key_path = tmp_path / f"{key}.gpg"
            # keyring 文件路径
            keyring_path = self.keyrings_path / f"{key}.gpg"

            if keyring_path.exists():
                # 获取keyring文件的最后修改时间
                keyring_mtime = keyring_path.stat().st_mtime

                # 将时间戳转化为 If-Modified-Since 格式
                keyring_mtime = pendulum.from_timestamp(keyring_mtime)
                keyring_mtime = keyring_mtime.in_tz("GMT")
                keyring_mtime = keyring_mtime.to_rfc1123_string()

                headers = {"If-Modified-Since": keyring_mtime} | dict(
                    self.client.headers
                )
            else:
                headers = dict(self.client.headers)

            # 流式下载二进制文件，同时使用 conditional get，避免重复下载
            with self.client.stream("GET", url, headers=headers) as r, open(
                tmp_key_path, "wb"
            ) as f:
                if r.status_code == httpx.codes.NOT_MODIFIED:
                    logger.warning(f"{key} keyring is up to date.")
                    continue

                r.raise_for_status()
                for chunk in r.iter_bytes():
                    f.write(chunk)
            # 使用 gpg 导入密钥
            sudo[
                gpg["--yes", "--dearmor", "-o", str(keyring_path), str(tmp_key_path)]
            ]()

    def recv_keys(self):
        keys_hash = BoxList(self.keys_hash)
        for key in keys_hash:
            logger.info(f"Importing {key['name']} keyring...")
            sudo[
                gpg[
                    "--keyserver",
                    key.keyserver,
                    "--no-default-keyring",
                    "--keyring",
                    str(self.keyrings_path / f"{key.name}.gpg"),
                    "--recv-keys",
                ]
            ][
                key.key_hash
            ]()  # 必须将 key_hash 再作为另一个 [] 内的参数，否则会重复转义
            # https://github.com/tomerfiliba/plumbum/issues/253#issuecomment-169840952
            # https://github.com/tomerfiliba/plumbum/issues/124#issuecomment-54664378


# %%
if __name__ == "__main__":
    # 将日志级别设置为 DEBUG
    logger.remove()
    logger.add(sys.stderr, level="DEBUG")

    gpg_keys = GpgKeys()
    fire.Fire(gpg_keys.import_keys)
