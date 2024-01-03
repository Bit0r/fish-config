#!/usr/bin/fish

source include/confirm.fish

# 安装fish配置
source ./configs-fish.fish

# 安装字体
if confirm 'Do you want to install some third-party fonts?'
    source fonts.fish
end

# 添加apt源
source ./apt-sources.fish

# 使用apt安装软件
source ./apt-install.fish

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
