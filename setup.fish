#!/usr/bin/fish

source include/confirm.fish

# 安装fish配置
source ./config-fish.fish

# 配置系统包管理
if type -q apt
    source ./config-apt.fish
else if type -q zypper
    source ./config-zypper.fish
end

# 安装系统包
source ./install-packages.fish

# 配置第三方包管理源
if confirm 'Do you want to configure third-party package manager sources?'
    source config-third-party.fish
end

# 使用第三方包管理安装额外软件
if confirm 'Do you want to use a third-party package manager to install some software packages?'
    source install-third-party.fish
end

# 安装系统配置
if confirm 'Do you want to install system configs?'
    source config-system.fish
end

# 安装用户配置
if confirm 'Do you want to install user configs?'
    source config-user.fish
end

# 安装一些下载特别耗时的软件
if confirm 'Do you want to install some software that downloads very slowly?'
    source install-slow.fish
end
