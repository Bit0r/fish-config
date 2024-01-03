#!/usr/bin/env fish

source ./include/confirm.fish

# 安装基本配置
if confirm 'Do you want to install the user-level configuration for fish?'
    source ./fish/variables/normal.fish
end

if confirm 'Do you want to install the system-level configuration for fish?'
    # sudo fish -c xxx 会切换到 root 用户，并读写 root 的 fish 环境变量和用户配置
    sudo fish -c 'source ./fish/variables/normal.fish'
    sudo fish -c 'source ./fish/variables/root.fish'
    source ./fish/alias.fish
    source /usr/share/fish/tools/web_config/sample_prompts/disco.fish
    funcsave fish_prompt
    funcsave fish_right_prompt
    sudo mv ~/.config/fish/functions/* /etc/fish/functions/
    sudo cp ./fish/functions/* /etc/fish/functions/
    sudo cp ./fish/conf.d/* /etc/fish/conf.d/
    sudo install exec/* /usr/local/bin/
end
