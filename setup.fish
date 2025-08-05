#!/usr/bin/fish

source include/confirm.fish

# 安装fish配置
source ./configs-fish.fish

# 配置系统包管理源
if type -q apt
    source ./sources-apt.fish
else if type -q zypper
    source ./sources-zypper.fish
end

# 安装系统包
source ./install-packages.fish

# 配置第三方包管理源
if confirm 'Do you want to configure third-party package manager sources?'
    source registry.fish
end

# 使用第三方包管理安装额外软件
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
if confirm 'Do you want to install some software that downloads very slowly?'
    source slow.fish
end
