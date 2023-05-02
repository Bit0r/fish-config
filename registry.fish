#!/usr/bin/fish

#echo 'set -e FNM_NODE_DIST_MIRROR' >>~/.config/fish/conf.d/fnm.fish
set -Ux FNM_NODE_DIST_MIRROR 'https://repo.huaweicloud.com/nodejs/'

if type -q pip
    sudo pip config --global set global.index-url 'https://mirrors.cloud.tencent.com/pypi/simple'
end

cp config/.condarc ~/

mkdir -p ~/.config/go/ && cp config/go.env ~/.config/go/env

cp config/{.npmrc,.yarnrc} ~/
sudo cp config/{.npmrc,.yarnrc} /root/

mkdir -p /etc/docker/ && sudo cp config/daemon.json /etc/docker/

set -Ux RUSTUP_DIST_SERVER 'https://mirrors.tuna.tsinghua.edu.cn/rustup'
set -Ux RUSTUP_UPDATE_ROOT 'https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup'

mkdir -p ~/.cargo/ && cp config/cargo.cfg ~/.cargo/config

if type -q kaggle
    kaggle config set -n proxy -v 'http://localhost:8800'
end
