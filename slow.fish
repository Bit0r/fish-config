#!/usr/bin/fish

source include/confirm.fish

if confirm 'Do you want to install the software from the third-party repository?'
    # 设置包
    set files pkglist/{ppa,third-party}.txt
    set pkgs (cat $files | grep -v '^#')
    # 设置代理
    sudo cp ./config/apt/apt.conf.d/12proxy /etc/apt/apt.conf.d/
    # 开始安装
    sudo apt update
    sudo apt install $pkgs
end

if confirm 'Do you want to install calibre?'
    proxy-aria2c -d /tmp 'https://download.calibre-ebook.com/linux-installer.sh'
    sudo http_proxy='http://localhost:8800' sh /tmp/linux-installer.sh
end

if confirm 'Do you want to install ttf-mscorefonts-installer?'
    sudo http_proxy='http://localhost:8800' apt install --reinstall ttf-mscorefonts-installer
end

if confirm 'Do you want to install fnm?'
    proxy-curl -fsSL 'https://fnm.vercel.app/install' | http_proxy bash
end

if confirm 'Do you want to install fcitx5-rime plugins?'
    mkdir -p ~/.local/share/fcitx5/
    ~/.local/share/fcitx5/
    proxy-aria2c -d /tmp 'https://raw.githubusercontent.com/rime/plum/master/rime-install'
    sudo install /tmp/rime-install /usr/local/bin/
    rime-install iDvel/rime-ice:others/recipes/full
    rime-install BlindingDark/rime-easy-en
    prevd
end

if confirm 'Do you want to install WPS-Zotero?'
    git clone 'https://github.com/tankwyn/WPS-Zotero.git' ./repos/WPS-Zotero
    ./repos/WPS-Zotero/install.py
end

if confirm 'Do you wang to install d2lang?'
    proxy-curl -fsSL https://d2lang.com/install.sh | http_proxy sh -s --
    proxy-curl -fsSL https://d2lang.com/install.sh | http_proxy sh -s -- --tala
end

if confirm 'Do you want to install fisher?'
    proxy-curl -fsSL 'https://git.io/fisher' | source
    fisher update
end

if confirm 'Do you want to install the software from the GitHub release?'
    if [ -f ./tmp/releases.csv ]
        set lockfile $PWD/tmp/releases.csv
    else
        set lockfile $PWD/pkglist/releases.csv
    end

    python exec/download-releases \
        --lockfile=$lockfile \
        --output_dir=$PWD/tmp/
    sudo apt install ./tmp/*.deb
end
