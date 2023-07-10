#!/usr/bin/fish

source include/confirm.fish

# 添加文件配置

mkdir -p ~/.config/{fish/conf.d,profile.d,git,aria2,smplayer,keepassxc}
mkdir -p ~/.local/share/pandoc/{defaults,csl,css,docx}
mkdir -p ~/.local/share/kservices5/ServiceMenus

#xdg-user-dirs-update

cat config/profile.sh >>~/.profile

ln -s ~/anaconda3/etc/fish/conf.d/conda.fish ~/.config/fish/conf.d/
ln -s ~/anaconda3/etc/profile.d/conda.sh ~/.config/profile.d/
# 如果要使用mambaforge，取消下面两行的注释，同时注释上面两行。
#ln -s ~/mambaforge/etc/fish/conf.d/*.fish ~/.config/fish/conf.d/
#ln -s ~/mambaforge/etc/profile.d/*.sh ~/.config/profile.d/

#cp config/konsole.conf ~/.local/share/konsole/配置方案-1.profile
cp config/.*rc ~/
sudo cp config/.*rc /root/
mkdir -pm 0700 ~/.ssh/ && cp config/ssh.conf ~/.ssh/config
if type -q python
    cp config/usercustomize.py (python -m site --user-site)/
end

cp config/.gitconfig ~/.config/git/config
cp config/pandoc.yaml ~/.local/share/pandoc/defaults/
for suffix in csl css
    cp config/*.$suffix ~/.local/share/pandoc/$suffix/
end
cp config/aria2.conf ~/.config/aria2/
cp config/smplayer.ini ~/.config/smplayer/
cp config/mat2.desktop ~/.local/share/kservices5/ServiceMenus/
cp config/keepassxc.ini ~/.config/keepassxc/

update-mime-database ~/.local/share/mime/

sudo cp config/mpv.conf /etc/mpv/
sudo cp config/tmux.conf /etc/tmux.conf
sudo cp config/mysql.cnf /etc/mysql/conf.d/
sudo cp config/mycli.conf /etc/myclirc
sudo cp config/aria2@.service /etc/systemd/system/
sudo cp config/imwheel.service /etc/systemd/user/
sudo mkdir -p /etc/systemd/system/xray.service.d/
sudo cp config/xray-local.service /etc/systemd/system/xray.service.d/local.conf

sudo mkdir -p /root/.config/aria2/ && sudo cp config/aria2.conf /root/.config/aria2/
sudo mkdir -p /usr/local/share/applications/
sudo mkdir -p /usr/local/share/mime/packages/
for app_image in CAJViewer ivySCI
    sudo ln -s /opt/$app_image/$app_image.AppImage /usr/local/bin/$app_image
    sudo cp config/$app_image.desktop /usr/local/share/applications/
end
sudo cp config/caj-viewer.xml /usr/local/share/mime/packages/
sudo cp config/xray-logrotate.cfg /etc/logrotate.d/xray

systemctl --user daemon-reload
sudo systemctl daemon-reload

sudo update-mime-database /usr/local/share/mime/
sudo update-apt-xapian-index

# 修改内核参数
if confirm 'Do you want to optimize kernel parameters?'
    sudo cp config/sysctl.conf /etc/sysctl.d/local.conf
end


# 添加命令行配置

sudo snap set system snapshots.automatic.retention=no

if [ -d /var/www/ ]
    sudo chown www-data:www-data /var/www/
    sudo chmod 2775 /var/www/
end

sudo mkdir -m 2775 /srv/www/
sudo chown www-data:www-data /srv/www/

# 配置update-alternatives
if confirm 'Do you want to configure update-alternatives?'
    sudo update-alternatives --install /usr/bin/editor editor /usr/bin/micro 80 --slave /usr/share/man/man1/editor.1.gz editor.1.gz /usr/share/man/man1/micro.1.gz
    #for v in (seq 9 12)
    #    sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-$v $v
    #    sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-$v $v
    #end
end

# 配置apt自动更新
if type -q unattended-upgrades && confirm 'Do you want to configure apt auto upgrade?'
    sudo cp config/50unattended-upgrades.c /etc/apt/apt.conf.d/50unattended-upgrades
end

# 创建mysql管理员
if type -q mysql && confirm 'Do you want to create a MySQL super user?'
    source mysql.fish
end

# 配置vncserver
if type -q vncserver && confirm 'Do you want to configure vncserver?'
    cp config/vncserver@.service ~/.config/systemd/user/
    vncpasswd
    sudo cp config/vnc.conf /etc/X11/xorg.conf.d/
end

# 将plasma-awesome作为默认桌面
if type -q awesome && type -q startplasma-x11 && confirm 'Do you want to use plasma-awesome as default desktop?'
    sudo cp config/plasma-awesome.desktop /usr/share/xsessions/
    sudo cp config/sddm.conf /etc/sddm.conf
end

# 配置LXD
if type -q lxd && confirm 'Do you want to configure LXD?'
    snap set lxd ui.enable=true
    snap restart --reload lxd
end

# 配置docker代理
if type -q docker && confirm 'Do you want to configure docker proxy?'
    mkdir -p ~/.docker/
    cp config/docker.conf ~/.docker/config.json
end

# 添加自身到必需的组
if confirm 'Do you want to add yourself to some groups?'
    for group in lp lpadmin adm systemd-journal ssl-cert www-data wireshark docker kvm input
        sudo adduser $USER $group
    end
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
    #sudo ufw allow 6800/tcp comment Aria2RPC
    #sudo ufw allow 5900:5910/tcp comment VNC
    sudo ufw allow 6006/tcp comment TensorBoard
    sudo ufw enable
end
