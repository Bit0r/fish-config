#!/usr/bin/fish

source include/confirm.fish

# 添加ppa
if confirm 'Do you want to add some ppa?'
    for ppa in (cat ./config/apt/ppa.txt | grep -v '^#')
        sudo apt-add-repository -yn ppa:$ppa
    end
    sudo cp ./config/apt/preferences.d/* /etc/apt/preferences.d/
end

# 添加外部源
if confirm 'Do you want to add some third-party apt sources?'
    sudo apt install curl

    set -l keyrings_dir /etc/apt/keyrings
    sudo mkdir -p $keyrings_dir

    set -l NODE_MAJOR 20
    for source_conf in (cat ./config/apt/sources.tsv | grep -v '^#')
        set source_conf (string split \t $source_conf)
        set -l source_name $source_conf[1]
        set -l key_url $source_conf[2]
        set -l source_url $source_conf[3]

        set -l key_path $keyrings_dir/$source_name.gpg

        proxy-curl -fsSL $key_url | sudo gpg --dearmor -o $key_path
        echo "echo $source_url" | source | sudo tee /etc/apt/sources.list.d/$source_name.list >/dev/null
    end

    # unit
    #sudo cp config/unit.list /etc/apt/sources.list.d/
end
