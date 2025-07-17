#!/usr/bin/fish

source include/confirm.fish

# 配置系统级环境变量
sudo cp ./config/environment/*.conf /etc/environment.d/

# 设置软链接
sudo ln -s /etc /usr/

# 配置日志文件权限
sudo chown -R :adm /var/log
sudo chmod -R 2775 /var/log

# 创建目录
sudo mkdir -p \
    /root/.config/{aria2,below,bat} \
    /usr/share/xsessions \
    /etc/{
        default,
        graftcp-local,
        cgproxy,
        conda,
        uv,
        mpv,
        procs,
        docker,
        mysql/conf.d,
        redis/conf.d,
        audit/rules.d,
        samba,
        frp,
        yamlfix
    } \
    /etc/systemd/{system,user}.conf.d \
    /usr/local/share/{
        applications,
        icons,
        mime/packages
    } \
    /usr/local/etc/xray \
    /opt/glance \
    /var/log/imaotai \
    /srv/api
sudo mkdir -pm 2775 /srv/www \
    $DOCKER_COMPOSE_DIR \
    $DOCKER_DATA_DIR

sudo chown -R :docker $DOCKER_COMPOSE_DIR $DOCKER_DATA_DIR

# 配置地区
if confirm 'Do you want to configure locale?'
    sudo timedatectl set-timezone Asia/Shanghai
    sudo cp ./config/locale/locale.conf /etc/locale.conf
    rm ~/.config/plasma-localerc
end

# 配置 sudo
#sudo cp ./config/sudo/sudoers.d/* /etc/sudoers.d/
sudo cp ./config/sudo/sudoers.d/umask /etc/sudoers.d/

# 配置 adduser
sudo cp ./config/adduser/adduser.conf /etc/adduser-sudoer.conf

# 配置 systemd service
sudo cp -a ./config/systemd/system/. /etc/systemd/system/
sudo cp -a ./config/systemd/user/. /etc/systemd/user/

# 配置 ssh
sudo ln -s /usr/bin/ksshaskpass /usr/lib/ssh/ssh-askpass

# 配置 bat
sudo cp ./config/bat/config /root/.config/bat/

# 配置 profile
sudo cp ./config/profile.d/* /etc/profile.d/

# 配置 auditd
sudo cp ./config/audit/rules.d/* /etc/audit/rules.d/

# 配置mysql
sudo cp ./config/mysql/mysql.cnf /etc/mysql/conf.d/
sudo cp ./config/mysql/mycli.conf /etc/myclirc

# 配置redis
#sudo sd '^bind 127.0.0.1' '#bind 127.0.0.1' /etc/redis/redis.conf
#sudo cp ./config/redis/conf.d/* /etc/redis/conf.d/

# 配置postgres
#sudo cp ./config/postgres/conf.d/* /etc/postgresql/14/main/conf.d/

# 配置conda
sudo cp ./config/python/conda/.* /etc/conda/

# 配置uv
sudo cp ./config/python/uv/* /etc/uv/

# 配置 yamlfix
sudo cp ./config/yamlfix/pyproject.toml /etc/yamlfix/

# 配置lf
sudo cp ./config/lf/lfrc /etc/
sudo ln -s /usr/share/doc/lf/examples/lfcd.fish /etc/fish/functions/
sudo ln -s /usr/share/doc/lf/examples/lf.fish /etc/fish/completions/

# 配置thelounge
sudo cp ./config/thelounge/config.js /etc/thelounge/

# 配置X11
sudo cp ./config/kde/plasma-awesome.desktop /usr/share/xsessions/
#sudo cp ./config/vnc/10-vnc.conf /etc/X11/xorg.conf.d/ # 该配置文件会导致无法启动x0vncserver

# 配置 Weylus
sudo addgroup --system uinput
sudo adduser $USER uinput
sudo cp ./config/weylus/60-weylus.rules /etc/udev/rules.d/

# 配置 syslog
sudo cp ./config/syslog/rsyslog.d/* /etc/rsyslog.d/
sudo cp ./config/syslog/logrotate.d/* /etc/logrotate.d/

# 配置 xray
sudo cp ./config/xray/config.json /usr/local/etc/xray/

# 配置 caddy
sudo setcap cap_net_bind_service=+ep (type -p caddy)

# 配置 goaccess
sudo cp -b ./config/goaccess/* /etc/goaccess/

# 配置 proxychains4
sudo cp --backup=t ./config/proxychains/proxychains4.conf /etc/

# 配置 graftcp
sudo cp --backup=t ./config/graftcp-local/graftcp-local.conf /etc/graftcp-local/

# 配置 cgproxy
sudo cp --backup=t ./config/cgproxy/config.json /etc/cgproxy/

# 配置 docker pull 代理
if type -q docker && confirm 'Do you want to configure docker pull proxy?'
    sudo cp -a ./config/docker/docker.service.d /etc/systemd/system/
end

# 配置aria2
sudo cp config/aria2/aria2.conf /root/.config/aria2/

# 配置glance
sudo cp ./config/glance/glance.yaml /etc/

# 配置labelme
sudo cp ./config/labelme/.labelmerc /root/

# 配置 ImageMagick
sudo cp ./config/ImageMagick/policy-open.xml /etc/ImageMagick-6/
sudo ln -bs /etc/ImageMagick-6/policy-open.xml /etc/ImageMagick-6/policy.xml

# 配置 imaotai
sudo cp ./config/imaotai/imaotai /etc/nginx/sites-available/

# 配置pip
sudo cp ./config/python/pip.conf /etc/

# 配置npm和yarn
sudo cp ./config/javascript/etc/* /etc/

# 配置 procs
sudo cp ./config/procs/* /etc/procs/

# 配置docker
sudo cp ./config/docker/daemon*.json /etc/docker/
# 配置 docker compose 文件
sudo cp -a ./config/docker/compose/. $DOCKER_COMPOSE_DIR/

# 配置 imwheel
#sudo cp ./config/imwheel/imwheelrc /etc/X11/imwheel/

# 配置 mpv
sudo cp ./config/smplayer/mpv.conf /etc/mpv/

# 配置 tmux
sudo cp ./config/tmux.conf /etc/

# 配置 yt-dlp
sudo cp ./config/yt-dlp.conf /etc/

# 配置 below
sudo cp ./config/below/belowrc.toml /root/.config/below/belowrc

# 关闭 baloo 文件索引
if type -q balooctl
    sudo cp ./config/kde/baloofilerc /root/.config/
    sudo balooctl suspend
    sudo balooctl disable
    sudo balooctl purge
end

# 配置桌面设置
#for app_image in CAJViewer ivySCI
for app_image in ivySCI
    sudo ln -s /opt/$app_image/$app_image.AppImage /usr/local/bin/$app_image
    sudo cp config/desktop/$app_image.desktop /usr/local/share/applications/
end
#sudo cp config/caj-viewer.xml /usr/local/share/mime/packages/
sudo ln -s /opt/**/cake_wallet /usr/local/bin/
sudo ln -s /opt/**/cakewallet_icon_1024.png /usr/local/share/icons/
sudo cp config/desktop/CakeWallet.desktop /usr/local/share/applications/

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
    sudo cp -ubR ./config/sysctl.d/. /etc/sysctl.d/
end

# 配置web服务目录
sudo chown www-data:www-data /srv/www/
if [ -d /var/www/ ]
    sudo chown www-data:www-data /var/www/
    sudo chmod 2775 /var/www/
end

# 配置update-alternatives
if confirm 'Do you want to configure update-alternatives?'
    #sudo update-alternatives --install /usr/bin/editor editor /usr/bin/micro 60 --slave /usr/share/man/man1/editor.1 editor.1 /usr/share/man/man1/micro.1
    sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/msedit 80
    sudo update-alternatives --install /usr/bin/pager pager /usr/bin/ov 80

    #sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/warp-terminal 80
    #sudo update-alternatives --install /usr/lib/liblaszip.so liblaszip.so /usr/lib/x86_64-linux-gnu/liblaszip.so.8 80

    #for v in (seq 9 12)
    #    sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-$v $v
    #    sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-$v $v
    #end
end

# 配置 lib
sudo ln -s /usr/lib/x86_64-linux-gnu/libtiff.so.6 /usr/lib/x86_64-linux-gnu/libtiff.so.5
sudo ln -s /usr/lib/x86_64-linux-gnu/libxml2.so.2 /usr/lib/x86_64-linux-gnu/libxml.so.2

# 配置apt自动更新
if type -q unattended-upgrades && confirm 'Do you want to configure apt auto upgrade?'
    sudo cp --backup=t ./config/apt/apt.conf.d/*-upgrades /etc/apt/apt.conf.d/
end

# 配置apt代理
if confirm 'Do you want to configure apt proxy?'
    sudo cp ./config/apt/apt.conf.d/12proxy /etc/apt/apt.conf.d/
end

# 配置 apt weak-key 警告
if confirm 'Do you want to disable apt weakkey warning?'
    sudo cp ./config/apt/apt.conf.d/80weakkey-warning /etc/apt/apt.conf.d/
end

# 配置winetricks自动更新
if confirm 'Do you want winetricks to auto-update?'
    sudo ln -s /usr/local/bin/update_winetricks /etc/cron.weekly/
end

# 创建mysql管理员
if type -q mysql && confirm 'Do you want to create a MySQL super user?'
    source mysql.fish
end

# 配置 minio
if confirm 'Do you want to configure MinIO?'
    sudo cp ./config/minio/env /etc/default/minio
    sudo adduser --system minio --group
end

# 将plasma-awesome作为默认桌面
if type -q awesome && type -q startplasma-x11 && confirm 'Do you want to use plasma-awesome as default desktop?'
    sudo cp --backup=t ./config/kde/sddm.conf /etc/sddm.conf
end

# 配置LXD
if type -q lxd && confirm 'Do you want to configure LXD?'
    # 配置LXD UI
    sudo snap set lxd ui.enable=true
    sudo systemctl reload snap.lxd.daemon
    # 创建x11配置文件
    lxc profile create x11
    cat ./config/lxd/x11.yaml | lxc profile edit x11
    sudo snap restart --reload lxd
end

# 配置samba
if type -q samba && confirm 'Do you want to configure Samba?'
    sudo cp --backup=t ./config/samba/smb.conf /etc/samba/
    sudo smbpasswd -a nobody
    sudo smbpasswd -a $USER
    testparm # 展示配置信息
    sudo systemctl restart smbd
end

# 配置 kyanos
if type -q kyanos
    set kyanos_path (type kyanos)
    sudo setcap cap_bpf,cap_sys_admin+ep $kyanos_path
    sudo chmod u+s $kyanos_path
end

# 配置 trippy
trip --generate-man | gzip | sudo tee /usr/local/share/man/man1/trip.1.gz >/dev/null

# 配置 cproxy
if type -q cproxy
    set cproxy_path (type cproxy)
    sudo chmod u+s $cproxy_path
end

# 配置libvirt
if type -q virsh && confirm 'Do you want to configure libvirt?'
    sudo cp --backup=t ./config/libvirt/qemu/*.xml /etc/libvirt/qemu/
    sudo cp --backup=t ./config/libvirt/storge/*.xml /etc/libvirt/storage/
end

# 设置防火墙
if confirm 'Do you want to configure firewall?'
    # 硬件服务
    sudo ufw allow 9/udp comment 'Wake on LAN'

    # 允许 LAN 内部访问
    sudo ufw allow from 10.0.0.0/8 comment 'A 类私有地址'
    sudo ufw allow from 172.16.0.0/12 comment 'B 类私有地址'
    sudo ufw allow from 192.168.0.0/16 comment 'C 类私有地址'

    # 系统服务
    sudo ufw limit ssh
    #sudo ufw allow 5900:5999/tcp comment VNC
    #sudo ufw allow 3389/tcp comment RDP
    #sudo ufw allow http
    #sudo ufw allow https
    #sudo ufw allow ipp
    #sudo ufw allow mdns
    #sudo ufw allow samba comment Samba
    #sudo ufw allow 5572/tcp comment 'Rclone Web GUI'

    # 容器服务
    #sudo ufw allow in on lxdbr0
    #sudo ufw route allow in on lxdbr0
    #sudo ufw route allow out on lxdbr0

    # 代理服务
    #sudo ufw allow socks comment 'socks5 proxy server'
    #sudo ufw allow 8800/tcp comment 'http proxy server'

    # 个人服务
    sudo ufw allow 1714:1764/tcp comment 'KDE Connect'
    sudo ufw allow 1714:1764/udp comment 'KDE Connect'
    sudo ufw allow 24800/tcp comment Barrier
    sudo ufw allow 1701/tcp comment 'Weylus HTTP'
    sudo ufw allow 9001/tcp comment 'Weylus Websocket'
    sudo ufw allow 6881:6999/tcp comment BitTorrent
    sudo ufw allow 6881:6999/udp comment DHT

    # 网络服务
    #sudo ufw allow 6800:6809/tcp comment Aria2RPC
    sudo ufw allow 9000/tcp comment thelounge
    sudo ufw allow 7860/tcp comment model-memory-usage
    sudo ufw allow 6006/tcp comment TensorBoard

    sudo ufw enable
end
