#!/usr/bin/fish

mkdir -p ~/.{cargo,m2,kaggle} \
    ~/.config/{pip,uv,go}

# 配置 fnm 镜像
#echo 'set -e FNM_NODE_DIST_MIRROR' >>~/.config/fish/conf.d/fnm.fish
set -Ux FNM_NODE_DIST_MIRROR 'https://repo.huaweicloud.com/nodejs/'

# 配置 conda 和 mamba 镜像
cp -b ./config/python/conda/.* ~/

# 配置 pip 镜像
cp ./config/python/pip.conf ~/.config/pip/

# 配置 uv 镜像
cp ./config/python/uv/* ~/.config/uv/

# 配置 poetry 镜像
set -Ux POETRY_PYPI_MIRROR_URL 'https://mirrors.aliyun.com/pypi/simple'

# 配置 go 镜像
cp -b ./config/go/env ~/.config/go/

# 配置 npm 和 yarn 镜像
cp -f config/javascript/.*rc ~/

# 配置 nrm 镜像
if type -q nrm
    nrm add huawei https://mirrors.huaweicloud.com/repository/npm/ https://mirrors.huaweicloud.com/home
end

# 配置 rustup 镜像
set -Ux RUSTUP_UPDATE_ROOT 'https://mirrors.cernet.edu.cn/rustup/rustup'
set -Ux RUSTUP_DIST_SERVER 'https://mirrors.cernet.edu.cn/rustup'

# 配置 cargo 镜像
cp -b ./config/rust/cargo.toml ~/.cargo/

# 配置 maven 镜像
cp -b ./config/java/maven/settings.xml ~/.m2/

# 配置 kaggle 代理
if type -q kaggle
    touch ~/.kaggle/kaggle.json
    chmod 600 ~/.kaggle/kaggle.json
    kaggle config set -n proxy -v 'http://localhost:8800'
end

# 配置 lxc 镜像
if type -q lxc
    lxc remote add mirror-images https://mirrors.cernet.edu.cn/lxc-images/ --protocol=simplestreams --public
end
