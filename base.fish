#!/usr/bin/fish

source include/confirm.fish

# 定义清单函数
set pkglist
function add-list -d 'Add a package list' -a msg pkg
    if confirm $msg
        set -a pkglist $pkg
    end
end

# 添加清单
add-list 'Do you want to install C?' c
add-list 'Do you want to install PHP?' php
add-list 'Do you want to install Python dependencies?' python
add-list 'Do you want to install the Web development infrastructure?' web
add-list 'Do you want to install Java?' java
add-list 'Do you want to install Rust?' rust
add-list 'Do you want to install some awesome cli softwares?' cli
add-list 'Do you want to install some awesome gui softwares?' gui
add-list 'Do you want to install the printer driver?' printer
add-list 'Do you want to install nvidia-gui?' nvidia
add-list 'Do you want to install some software docs?' doc
add-list 'Do you want to install some official fonts?' fonts
add-list 'Do you want to install office suite?' office
add-list 'Do you want to install docker?' docker
add-list 'Do you want to install LXD?' lxd
add-list 'Do you want to install virtualbox?' virtualbox

# 开始安装
set files /dev/null
for pkg in $pkglist
    set -a files pkglist/$pkg.txt
end
sudo apt install (cat $files)

# 使用aptss安装软件包
#sudo apt install aptss
#sudo aptss install (cat pkglist/spark.txt)
