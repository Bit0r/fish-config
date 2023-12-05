#!/usr/bin/fish

source include/confirm.fish

# 设置软链接
sudo ln -s /etc /usr/

# 创建目录
sudo mkdir -p \
    /root/.config/aria2 \
    /usr/share/xsessions \
    /etc/{mpv,docker,mysql/conf.d} \
    /etc/systemd/system/xray.service.d \
    /usr/local/share/{applications,mime/packages}

# 配置 sudo
#sudo cp ./config/sudo/sudoers.d/* /etc/sudoers.d/

# 配置mysql
sudo cp ./config/mysql/mysql.cnf /etc/mysql/conf.d/
sudo cp ./config/mysql/mycli.conf /etc/myclirc

# 配置Xray
sudo cp config/xray/xray-local.service /etc/systemd/system/xray.service.d/local.conf
sudo cp config/xray/xray-logrotate.cfg /etc/logrotate.d/xray

# 配置X11
sudo cp ./config/kde/plasma-awesome.desktop /usr/share/xsessions/
sudo cp ./config/vnc/10-vnc.conf /etc/X11/xorg.conf.d/

# 配置aria2
sudo cp config/aria2/aria2@.service /etc/systemd/system/
sudo cp config/aria2/aria2.conf /root/.config/aria2/

# 配置pip
sudo cp ./config/python/pip.conf /etc/

# 配置npm和yarn
sudo cp config/{.npmrc,.yarnrc} /etc/

# 配置docker
sudo cp ./config/docker/daemon.json /etc/docker/

# 配置 imwheel
#sudo cp ./config/imwheel/imwheelrc /etc/X11/imwheel/
sudo cp ./config/imwheel/imwheel.service /etc/systemd/user/

# 配置杂项
sudo cp ./config/smplayer/mpv.conf /etc/mpv/
sudo cp config/tmux.conf /etc/tmux.conf

# 配置桌面设置
#for app_image in CAJViewer ivySCI
for app_image in ivySCI
    sudo ln -s /opt/$app_image/$app_image.AppImage /usr/local/bin/$app_image
    sudo cp config/desktop/$app_image.desktop /usr/local/share/applications/
end
#sudo cp config/caj-viewer.xml /usr/local/share/mime/packages/

# 配置snap
sudo snap set system snapshots.automatic.retention=no

# 重新加载systemd配置
systemctl --user daemon-reload
sudo systemctl daemon-reload

# 更新mime数据库
sudo update-mime-database /usr/local/share/mime/
# 更新muon软件包索引
sudo update-apt-xapian-index

# 修改内核参数
if confirm 'Do you want to optimize kernel parameters?'
    sudo cp config/sysctl.conf /etc/sysctl.d/local.conf
end

# 配置web服务目录
sudo mkdir -m 2775 /srv/www/
sudo chown www-data:www-data /srv/www/
if [ -d /var/www/ ]
    sudo chown www-data:www-data /var/www/
    sudo chmod 2775 /var/www/
end

# 配置update-alternatives
if confirm 'Do you want to configure update-alternatives?'
    sudo update-alternatives --install /usr/bin/editor editor /usr/bin/micro 80 --slave /usr/share/man/man1/editor.1.gz editor.1.gz /usr/share/man/man1/micro.1.gz
    #sudo update-alternatives --install /usr/lib/liblaszip.so liblaszip.so /usr/lib/x86_64-linux-gnu/liblaszip.so.8 80
    #for v in (seq 9 12)
    #    sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-$v $v
    #    sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-$v $v
    #end
end

# 配置apt自动更新
if type -q unattended-upgrades && confirm 'Do you want to configure apt auto upgrade?'
    sudo cp --backup=t config/apt/50unattended-upgrades.c /etc/apt/apt.conf.d/50unattended-upgrades
end

# 配置winetricks自动更新
if confirm 'Do you want winetricks to auto-update?'
    sudo ln -s /usr/local/bin/update_winetricks /etc/cron.weekly/
end

# 创建mysql管理员
if type -q mysql && confirm 'Do you want to create a MySQL super user?'
    source mysql.fish
end

# 将plasma-awesome作为默认桌面
if type -q awesome && type -q startplasma-x11 && confirm 'Do you want to use plasma-awesome as default desktop?'
    sudo cp --backup=t ./config/kde/sddm.conf /etc/sddm.conf
end

# 配置LXD
if type -q lxd && confirm 'Do you want to configure LXD?'
    sudo snap set lxd ui.enable=true
    cat ./config/lxd/x11.yaml | lxc profile edit x11
    sudo snap restart --reload lxd
end

# 设置防火墙
if confirm 'Do you want to configure firewall?'
    #sudo ufw allow in on lxdbr0
    #sudo ufw route allow in on lxdbr0
    #sudo ufw route allow out on lxdbr0
    sudo ufw limit ssh
    #sudo ufw allow http
    #sudo ufw allow https
    #sudo ufw allow ipp
    #sudo ufw allow mdns
    #sudo ufw allow 1080 comment 'socks5 proxy server'
    #sudo ufw allow 8800/tcp comment 'http proxy server'
    sudo ufw allow 1714:1764/tcp comment 'KDE Connect'
    sudo ufw allow 1714:1764/udp comment 'KDE Connect'
    sudo ufw allow 6881:6999/tcp comment BitTorrent
    sudo ufw allow 6881:6999/udp comment DHT
    #sudo ufw allow 6800:6809/tcp comment Aria2RPC
    #sudo ufw allow 5900:5910/tcp comment VNC
    sudo ufw allow 6006/tcp comment TensorBoard
    sudo ufw enable
end
