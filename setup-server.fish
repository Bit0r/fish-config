apt install unar xz-utils lnav pip bat language-pack-zh-hans python-dev-is-python3 software-properties-common

sudo cp -uRT ./config/sysctl.d/ /etc/sysctl.d/

sudo timedatectl set-timezone Asia/Shanghai
sudo cp ./config/locale/locale.conf /etc/locale.conf

#sudo passwd $USER # 修改密码
#chsh -s /usr/bin/fish # 修改默认shell
set -U fish_greeting

cp functions/cat.fish /etc/fish/functions/

# set -Ux EDITOR fresh

ufw limit ssh

# echo '[Unit]
# Description=Uncomplicated firewall
# Documentation=man:ufw(8)
# DefaultDependencies=no
# Before=network.target
# After=netfilter-persistent.service
#
# [Service]
# Type=oneshot
# RemainAfterExit=yes
# ExecStart=/lib/ufw/ufw-init start quiet
# ExecStop=/lib/ufw/ufw-init stop
#
# [Install]
# WantedBy=multi-user.target' >/etc/systemd/system/ufw.service
# ufw enable

# wget 'https://github.com/XTLS/Xray-install/raw/main/install-release.sh'
# chmod +x install-release.sh
# ./install-release.sh -u root

# cp ./config/xray/config-server.json /usr/local/etc/xray/config.json
# cp ./config/syslog/logrotate.d/xray /etc/logrotate.d/
