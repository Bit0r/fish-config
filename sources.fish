#!/usr/bin/fish

source include/confirm.fish

# 添加ppa
if confirm 'Do you want to add some ppa?'
    for ppa in (cat config/ppa.txt)
        sudo add-apt-repository -ynP $ppa
    end
    sudo cp config/mozilla /etc/apt/preferences.d/
    sudo apt update
end

# 添加外部源
if confirm 'Do you want to add other software sources?'
    sudo apt install curl

    # nodejs
    curl -fsSL 'https://deb.nodesource.com/setup_lts.x' | sudo -E bash -

    # docker
    curl -fsSL 'http://mirrors.163.com/docker-ce/linux/ubuntu/gpg' | gpg --dearmor | sudo tee /etc/apt/keyrings/docker-ce-163.gpg >/dev/null
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker-ce-163.gpg] https://mirrors.163.com/docker-ce/linux/ubuntu $UBUNTU_CODENAME stable" | sudo tee /etc/apt/sources.list.d/docker-ce-163.list >/dev/null

    # wine
    sudo wget -O /etc/apt/keyrings/winehq-archive.key 'https://dl.winehq.org/wine-builds/winehq.key'
    #sudo wget -NP /etc/apt/sources.list.d/ "https://dl.winehq.org/wine-builds/ubuntu/dists/$UBUNTU_CODENAME/winehq-$UBUNTU_CODENAME.sources"
    echo "deb [arch=amd64,i386 signed-by=/etc/apt/keyrings/winehq-archive.key] http://mirrors.cernet.edu.cn/wine-builds/ubuntu/ $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/winehq.list >/dev/null

    # zotero
    proxy-aria2c -d /tmp/ 'https://raw.githubusercontent.com/retorquere/zotero-deb/master/zotero-archive-keyring.gpg'
    sudo mv /tmp/zotero-archive-keyring.gpg /usr/share/keyrings/
    echo 'deb [signed-by=/usr/share/keyrings/zotero-archive-keyring.gpg by-hash=force] https://zotero.retorque.re/file/apt-package-archive ./' | sudo tee /etc/apt/sources.list.d/zotero.list >/dev/null

    # unit
    #sudo cp config/unit.list /etc/apt/sources.list.d/
end
