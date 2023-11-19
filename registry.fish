#!/usr/bin/fish

# 配置 fnm 镜像
#echo 'set -e FNM_NODE_DIST_MIRROR' >>~/.config/fish/conf.d/fnm.fish
set -Ux FNM_NODE_DIST_MIRROR 'https://repo.huaweicloud.com/nodejs/'

# 配置 conda 镜像
cp -f config/.condarc ~/

# 配置 pip 镜像
mkdir -p ~/.config/pip/
cp config/pip.conf ~/.config/pip/

# 配置 go 镜像
mkdir -p ~/.config/go/
cp config/go.env ~/.config/go/env

# 配置 npm 和 yarn 镜像
cp -f config/{.npmrc,.yarnrc} ~/

# 配置 rustup 镜像
set -Ux RUSTUP_UPDATE_ROOT 'https://mirrors.cernet.edu.cn/rustup/rustup'
set -Ux RUSTUP_DIST_SERVER 'https://mirrors.cernet.edu.cn/rustup'

# 配置 cargo 镜像
mkdir -p ~/.cargo/
cp config/cargo.cfg ~/.cargo/config

# 配置 kaggle 代理
if type -q kaggle
    kaggle config set -n proxy -v 'http://localhost:8800'
end

# 配置 lxc 镜像
if type -q lxc
    lxc remote add mirror-images https://mirrors.cernet.edu.cn/lxc-images/ --protocol=simplestreams --public
end
