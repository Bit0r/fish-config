apt install lnav micro pip bat git-crypt language-pack-zh-hans python-dev-is-python3 software-properties-common

set -U fish_greeting

echo 'net.ipv4.tcp_congestion_control=bbr
net.core.default_qdisc=fq' >/etc/sysctl.d/local.conf

ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
dpkg-reconfigure --frontend noninteractive tzdata
update-locale LANG="zh_CN.UTF-8" LANGUAGE="zh_CN:zh" LC_ALL="zh_CN.UTF-8"

cp functions/cat.fish /etc/fish/functions/
alias -s ls 'exa --group-directories-first -aF'

set EDITOR micro
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

cp config/config-server.json /usr/local/etc/xray/config.json
