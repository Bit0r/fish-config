#!/usr/bin/fish

source include/confirm.fish

# 定义清单函数
set pkglist
set patterns
function add-list -d 'Add a package list' -a msg pkgs
    if confirm $msg
        if type -q zypper
            switch $pkgs
                case c
                    set -a patterns devel_C_C++
                case java
                    set -a patterns devel_java
                case cli
                    set -a patterns enhanced_base laptop sw_management
                    set -a pkglist $pkgs
                case gui
                    set -a patterns imaging multimedia yast2_basis yast2_desktop
                    set -a pkglist $pkgs
                case docs
                    set -a patterns books documentation
                    set -a pkglist $pkgs
                case fonts
                    set -a patterns fonts
                    set -a pkglist $pkgs
                case games
                    set -a patterns games
                    set -a pkglist $pkgs
                case libvirt
                    set -a patterns 'kvm_*'
                    set -a pkglist $pkgs
                case printer
                    set -a patterns 'printer_*'
                    set -a pkglist $pkgs
                case '*'
                    set -a pkglist $pkgs
            end
        end

        if type -q apt
            set -a pkglist $pkgs
        end
    end
end

# 添加清单
add-list 'Do you want to install C?' c
add-list 'Do you want to install Python dependencies?' python
add-list 'Do you want to install JavaScript?' javascript
add-list 'Do you want to install the Go?' go
add-list 'Do you want to install Rust?' rust
add-list 'Do you want to install the Web development infrastructure?' web
add-list 'Do you want to install Java?' java
add-list 'Do you want to install PHP?' php
add-list 'Do you want to install some awesome cli software?' cli
add-list 'Do you want to install some awesome gui software?' gui
add-list 'Do you want to install some awesome kde software?' kde
add-list 'Do you want to install the printer driver?' printer
add-list 'Do you want to install nvidia-gui?' nvidia
add-list 'Do you want to install some software docs?' docs
add-list 'Do you want to install some official fonts?' fonts
add-list 'Do you want to install office suite?' office
add-list 'Do you want to install docker?' docker
add-list 'Do you want to install wine?' wine
add-list 'Do you want to install LXD?' lxd
# add-list 'Do you want to install virtualbox?' virtualbox
add-list 'Do you want to install libvirt?' libvirt
add-list 'Do you want to install some games?' games
add-list 'Do you want to install xfce?' xfce
add-list 'Do you want to install vnc server?' vnc

# 开始安装
set files /dev/null
for pkgs in $pkglist
    set -a files pkglist/$pkgs.txt
end
set pkgs (cat $files | grep -v '^#')

if type -q apt
    sudo apt update
    sudo apt -m install $pkgs
else if type -q zypper
    sudo zypper refresh
    sudo zypper -i install -l $pkgs
end
