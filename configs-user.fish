#!/usr/bin/fish

source include/confirm.fish

# 创建目录
mkdir -p ~/.vnc
mkdir -p ~/.config/{fish/conf.d,profile.d,git,aria2,pip,smplayer,keepassxc,matplotlib}
mkdir -p ~/.local/share/pandoc/{defaults,csl,css,docx}
mkdir -p ~/.local/share/{kservices5/ServiceMenus,mime/packages}
mkdir -pm 700 ~/.ssh/controls
#xdg-user-dirs-update

# 创建一个用户级别的 profile.d
cat config/profile.sh >>~/.profile

#ln -sf ~/anaconda3/etc/fish/conf.d/conda.fish ~/.config/fish/conf.d/
#ln -sf ~/anaconda3/etc/profile.d/conda.sh ~/.config/profile.d/
# 如果要使用mambaforge，取消下面两行的注释，同时注释上面两行。
ln -sf ~/mambaforge/etc/fish/conf.d/*.fish ~/.config/fish/conf.d/
ln -sf ~/mambaforge/etc/profile.d/*.sh ~/.config/profile.d/

#cp config/konsole.conf ~/.local/share/konsole/配置方案-1.profile

# 复制rc文件
cp -f config/.*rc ~/
cp config/matplotlibrc ~/.config/matplotlib/
cp config/konsolerc.cfg ~/.config/konsolerc

# 配置pip
#cp config/pip.conf ~/.config/pip/

# 配置xorg
cp config/.xprofile ~/.xprofile

# 配置ssh
mkdir -pm 0700 ~/.ssh/ && cp config/ssh.conf ~/.ssh/config

# 配置git
cp config/.gitconfig ~/.config/git/config

# 配置aria2
cp config/aria2.conf ~/.config/aria2/

cp config/smplayer.ini ~/.config/smplayer/
cp config/mat2.desktop ~/.local/share/kservices5/ServiceMenus/
cp config/keepassxc.ini ~/.config/keepassxc/

# 配置python
if type -q python
    cp config/usercustomize.py (python -m site --user-site)/
end

# 配置pandoc
cp config/pandoc.yaml ~/.local/share/pandoc/defaults/
for suffix in csl css
    cp config/*.$suffix ~/.local/share/pandoc/$suffix/
end

# 更新mime数据库
update-mime-database ~/.local/share/mime/

# 配置vncserver
cp config/vnc.cfg ~/.vnc/config
if type -q vncserver && confirm 'Do you want to configure vncserver?'
    vncpasswd
    vncserver
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
