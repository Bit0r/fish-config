#!/usr/bin/fish

source include/confirm.fish

# 安装基本配置
if confirm 'Do you want to install configs?'
    source config/variables.fish
    source config/alias.fish
    sudo mv ~/.config/fish/functions/* /etc/fish/functions/
    sudo cp functions/* /etc/fish/functions/
    sudo install exec/* /usr/local/bin/
end

# 安装字体
if confirm 'Do you want to install fonts?'
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
if confirm 'Do you want to use external package manager to install some softwares?'
    source extra.fish
end

# 修改系统配置
if confirm 'Do you want to install some softwares config?'
    source configs.fish
end

# 安装一些下载特别耗时的软件
if confirm 'Do you want to install some softwares that downloads very slowly?'
    source slow.fish
end
