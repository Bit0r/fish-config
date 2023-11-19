#!/usr/bin/fish

#echo 'set -e FNM_NODE_DIST_MIRROR' >>~/.config/fish/conf.d/fnm.fish
set -Ux FNM_NODE_DIST_MIRROR 'https://repo.huaweicloud.com/nodejs/'

cp -f config/.condarc ~/

cp config/pip.conf ~/.config/pip/

mkdir -p ~/.config/go/ && cp config/go.env ~/.config/go/env

cp -f config/{.npmrc,.yarnrc} ~/

set -Ux RUSTUP_UPDATE_ROOT 'https://mirrors.cernet.edu.cn/rustup/rustup'
set -Ux RUSTUP_DIST_SERVER 'https://mirrors.cernet.edu.cn/rustup'

mkdir -p ~/.cargo/ && cp config/cargo.cfg ~/.cargo/config

if type -q kaggle
    kaggle config set -n proxy -v 'http://localhost:8800'
end

if type -q lxc
    lxc remote add mirror-images https://mirrors.cernet.edu.cn/lxc-images/ --protocol=simplestreams --public
end
