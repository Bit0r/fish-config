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
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    curl -fsSL http://mirrors.163.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://mirrors.163.com/docker-ce/linux/ubuntu $UBUNTU_CODENAME stable"
    sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
    sudo wget -NP /etc/apt/sources.list.d/ "https://dl.winehq.org/wine-builds/ubuntu/dists/$UBUNTU_CODENAME/winehq-$UBUNTU_CODENAME.sources"
    #sudo cp config/unit.list /etc/apt/sources.list.d/
end
