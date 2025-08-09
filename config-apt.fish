#!/usr/bin/fish

source include/confirm.fish

# 配置apt自动更新
if confirm 'Do you want to configure apt auto upgrade?'
    sudo cp --backup=t ./config/apt/apt.conf.d/*-upgrades /etc/apt/apt.conf.d/
end

# 配置apt代理
if confirm 'Do you want to configure apt proxy?'
    sudo cp ./config/apt/apt.conf.d/12proxy /etc/apt/apt.conf.d/
end

# 配置 apt weak-key 警告
if confirm 'Do you want to disable apt weakkey warning?'
    sudo cp ./config/apt/apt.conf.d/80weakkey-warning /etc/apt/apt.conf.d/
end

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

    NODE_MAJOR=22 python sources_manager.py add_sources

    # unit
    #sudo cp config/unit.list /etc/apt/sources.list.d/
end
