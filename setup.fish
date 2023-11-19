#!/usr/bin/fish

source include/confirm.fish

# 安装基本配置
if confirm 'Do you want to install the user-level configuration for fish?'
    source config/variables.fish
end

if confirm 'Do you want to install the system-level configuration for fish?'
    source config/alias.fish
    source /usr/share/fish/tools/web_config/sample_prompts/disco.fish
    funcsave fish_prompt
    funcsave fish_right_prompt
    sudo mv ~/.config/fish/functions/* /etc/fish/functions/
    sudo cp functions/* /etc/fish/functions/
    sudo install exec/* /usr/local/bin/
end

# 安装字体
if confirm 'Do you want to install some third-party fonts?'
    source fonts.fish
end

# 添加apt源
source sources.fish

# 使用apt安装软件
source base.fish

# 进行软件源配置
if confirm 'Do you want to configure software registries?'
    source registry.fish
end

# 使用包管理安装额外软件
if confirm 'Do you want to use a third-party package manager to install some software packages?'
    source third-party.fish
end

# 安装系统配置
if confirm 'Do you want to install system configs?'
    source configs-system.fish
end

# 安装用户配置
if confirm 'Do you want to install user configs?'
    source configs-user.fish
end

# 安装一些下载特别耗时的软件
if confirm 'Do you want to install some softwares that downloads very slowly?'
    source slow.fish
end
