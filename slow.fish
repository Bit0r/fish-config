#!/usr/bin/fish

source include/confirm.fish

if type -q apt && confirm 'Do you want to install the software from the third-party repository?'
    # 设置包
    set files pkglist/{ppa,third-party}.txt
    set pkgs (cat $files | grep -v '^#')
    # 设置代理
    sudo cp ./config/apt/apt.conf.d/12proxy /etc/apt/apt.conf.d/
    # 开始安装
    sudo apt update
    sudo apt -m install $pkgs
end

if confirm 'Do you want to install dysk?'
    proxy-aria2c -d /tmp 'https://dystroy.org/dysk/download/x86_64-linux/dysk'
    install /tmp/dysk
end

if confirm 'Do you want to install ttf-mscorefonts-installer?'
    sudo http_proxy='http://localhost:8800' apt install --reinstall ttf-mscorefonts-installer
end

if confirm 'Do you want to install fnm?'
    proxy-curl -fsSL 'https://fnm.vercel.app/install' | http_proxy bash
end

# if confirm 'Do you want to install Grit?'
#     proxy-curl -fsSL 'https://docs.grit.io/install' | http_proxy bash
#     http_proxy grit install --app gouda
#     http_proxy grit install --app workflow-runner
# end

if confirm 'Do you want to install fcitx5-rime plugins?'
    mkdir -p ~/.local/share/fcitx5/
    ~/.local/share/fcitx5/
    proxy-aria2c -d /tmp 'https://raw.githubusercontent.com/rime/plum/master/rime-install'
    install /tmp/rime-install
    rime-install iDvel/rime-ice:others/recipes/full
    rime-install BlindingDark/rime-easy-en
    prevd
end

if confirm 'Do you wang to install d2lang?'
    proxy-curl -fsSL https://d2lang.com/install.sh | http_proxy sh -s --
    proxy-curl -fsSL https://d2lang.com/install.sh | http_proxy sh -s -- --tala
end

if confirm 'Do you want to install fisher?'
    proxy-curl -fsSL 'https://git.io/fisher' | source
    http_proxy fisher update
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

    if type -q apt
        sudo apt install ./tmp/*.deb
    else if type -q zypper
        sudo zypper install ./tmp/*.rpm
    end
end
