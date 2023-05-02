#!/usr/bin/fish

source include/confirm.fish

sudo http_proxy='http://localhost:8800' apt install ttf-mscorefonts-installer


if confirm 'Do you want to install calibre?'
    proxy-aria2c -d /tmp 'https://download.calibre-ebook.com/linux-installer.sh'
    sudo http_proxy='http://localhost:8800' sh /tmp/linux-installer.sh
end

if confirm 'Do you want to install fnm?'
    proxy-curl -fsSL 'https://fnm.vercel.app/install' | http_proxy='http://localhost:8800' bash
end

git clone 'https://github.com/iDvel/rime-ice.git' ~/.local/share/fcitx5/rime

if confirm 'Do you want to download the software from the GitHub release?'
    mkdir tmp/
    cp pkglist/releases.csv tmp/
    tmp/
    download-releases
    sudo apt install ./*.deb
    ../
end
