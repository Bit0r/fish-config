#!/usr/bin/fish

source include/confirm.fish

#sudo http_proxy='http://localhost:8800' apt install ttf-mscorefonts-installer

if confirm 'Do you want to install calibre?'
    proxy-aria2c -d /tmp 'https://download.calibre-ebook.com/linux-installer.sh'
    sudo http_proxy='http://localhost:8800' sh /tmp/linux-installer.sh
end

if confirm 'Do you want to install ttf-mscorefonts-installer?'
    sudo http_proxy='http://localhost:8800' apt install --reinstall ttf-mscorefonts-installer
end

if confirm 'Do you want to install fnm?'
    proxy-curl -fsSL 'https://fnm.vercel.app/install' | http_proxy='http://localhost:8800' bash
end

git clone 'https://github.com/iDvel/rime-ice.git' ~/.local/share/fcitx5/rime

git clone 'https://github.com/tankwyn/WPS-Zotero.git' ./repos/WPS-Zotero
./repos/WPS-Zotero/install.py

proxy-curl -fsSL https://d2lang.com/install.sh | sh -s --

proxy-curl -fsSL 'https://cli.github.com/packages/githubcli-archive-keyring.gpg' | gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null

if confirm 'Do you want to install GitHub CLI?'
    sudo apt upgrade
    sudo apt install gh
end

if confirm 'Do you want to download the software from the GitHub release?'
    mkdir tmp/
    cp pkglist/releases.csv tmp/
    tmp/
    download-releases
    sudo apt install ./*.deb
    ../
end
