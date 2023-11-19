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
if confirm 'Do you want to add some third-party apt sources?'
    sudo apt install curl

    # nodejs
    curl -fsSL 'https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key' | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
    set -l NODE_MAJOR 20
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list >/dev/null

    # HashiCorp
    #proxy-wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    #echo "deb [arch=amd64 signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

    # docker
    curl -fsSL 'http://mirrors.163.com/docker-ce/linux/ubuntu/gpg' | sudo gpg --dearmor -o /etc/apt/keyrings/docker-ce-163.gpg
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
