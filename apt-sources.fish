#!/usr/bin/fish

source include/confirm.fish

# 添加ppa
if confirm 'Do you want to add some ppa?'
    for ppa in (cat ./config/apt/ppa.txt | grep -v '^#')
        sudo apt-add-repository -yn ppa:$ppa
    end
    sudo cp ./config/apt/preferences.d/* /etc/apt/preferences.d/
end

# 添加 gpg key
if confirm 'Do you want to add some gpg keys?'
    pip install -Ur requirements.txt

    python keys_manager.py import_keys
end

# 添加外部源
if confirm 'Do you want to add some third-party apt sources?'
    pip install -Ur requirements.txt

    NODE_MAJOR=20 python sources_manager.py add_sources

    # unit
    #sudo cp config/unit.list /etc/apt/sources.list.d/
end

# flatpak 换源
if confirm 'Do you want to change flatpak source?'
    sudo flatpak remote-modify flathub --url=https://mirrors.ustc.edu.cn/flathub --homepage=https://mirrors.ustc.edu.cn --title="中国科学技术大学镜像"
end
