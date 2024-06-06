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
    pip install -r requirements.txt

    python keys_add.py
end

# 添加外部源
if confirm 'Do you want to add some third-party apt sources?'
    pip install -r requirements.txt

    NODE_MAJOR=20 python sources_add.py

    # unit
    #sudo cp config/unit.list /etc/apt/sources.list.d/
end
