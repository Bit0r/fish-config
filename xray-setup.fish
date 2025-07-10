apt install unar xz-utils lnav micro pip bat language-pack-zh-hans python-dev-is-python3 software-properties-common

echo 'net.ipv4.tcp_congestion_control=bbr
net.core.default_qdisc=fq' >/etc/sysctl.d/local.conf

sudo timedatectl set-timezone Asia/Shanghai
sudo cp ./config/locale/locale.conf /etc/locale.conf

#sudo passwd $USER # 修改密码
#chsh -s /usr/bin/fish # 修改默认shell
set -U fish_greeting

cp functions/cat.fish /etc/fish/functions/

set -Ux EDITOR msedit
update-alternatives --install /usr/bin/editor editor /usr/bin/micro 80 --slave /usr/share/man/man1/editor.1.gz editor.1.gz /usr/share/man/man1/micro.1.gz

ufw limit ssh
ufw allow https
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

wget 'https://github.com/XTLS/Xray-install/raw/main/install-release.sh'
chmod +x install-release.sh
./install-release.sh -u root

cp ./config/xray/config-server.json /usr/local/etc/xray/config.json
cp ./config/syslog/logrotate.d/xray /etc/logrotate.d/
