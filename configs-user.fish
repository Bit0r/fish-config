#!/usr/bin/fish

source include/confirm.fish

# 创建目录
mkdir -p \
    ~/.vnc \
    ~/.config/{fish/conf.d,profile.d,git,bat,aria2,pip,tabby,smplayer,keepassxc,matplotlib,discord,ruff,micro,bililive} \
    ~/.local/share/{kservices5/ServiceMenus,mime/packages,konsole,pandoc/{defaults,csl,css,docx}}
mkdir -pm 700 ~/.ssh/controls
#xdg-user-dirs-update

# 创建一个用户级别的 profile.d
cat ./config/bash/profile.d.sh >>~/.profile

# NOTE: 这下面的3种配置只能选一种

# 1. anaconda3
#ln -sf ~/anaconda3/etc/fish/conf.d/conda.fish ~/.config/fish/conf.d/
#ln -sf ~/anaconda3/etc/profile.d/conda.sh ~/.config/profile.d/

# 2. miniforge3
#ln -sf ~/miniforge3/etc/fish/conf.d/*.fish ~/.config/fish/conf.d/
#ln -sf ~/miniforge3/etc/profile.d/*.sh ~/.config/profile.d/

# 3. micromamba
micromamba shell init -s fish ~/micromamba

# 复制rc文件
cp -f config/.*rc ~/

# 关闭 baloo 文件索引
if type -q balooctl
    cp ./config/kde/baloofilerc ~/.config/
    balooctl suspend
    balooctl disable
    balooctl purge
end

# 配置 konsole
cp config/konsole/*.profile ~/.local/share/konsole/
cp config/konsole/konsolerc ~/.config/

# 配置 tabby
cp ./config/tabby/config.yml ~/.config/tabby/

# 配置 bat
cp ./config/bat/config ~/.config/bat/

# 配置 micro
cp ./config/micro/settings.json ~/.config/micro/

# 配置pip
#cp config/pip.conf ~/.config/pip/

# 配置 x0vncserver
if type -q x0vncserver && confirm 'Do you want to configure x0vncserver?'
    cp ./config/.xprofile ~/.xprofile
end

# 配置ssh
mkdir -pm 0700 ~/.ssh/ && cp ./config/ssh/ssh.conf ~/.ssh/config

# 配置git
cp config/.gitconfig ~/.config/git/config

# 配置aria2
cp ./config/aria2/aria2.conf ~/.config/aria2/

# 配置bililive
cp ./config/bililive/config.yaml ~/.config/bililive/

cp ./config/smplayer/smplayer.ini ~/.config/smplayer/
cp ./config/desktop/mat2.desktop ~/.local/share/kservices5/ServiceMenus/
cp config/keepassxc.ini ~/.config/keepassxc/

# 配置python
if type -q python
    cp ./config/python/usercustomize.py (python -m site --user-site)/
end
# 配置 matplotlib
cp -b ./config/python/matplotlib/* ~/.config/matplotlib/
# 配置 ruff
cp ./config/python/ruff/* ~/.config/ruff/
if type -q ruff
    ruff generate-shell-completion fish >~/.config/fish/completions/ruff.fish
    sudo mv ~/.config/fish/completions/* /etc/fish/completions/
end

# 配置pandoc
cp config/pandoc/*.yaml ~/.local/share/pandoc/defaults/
for suffix in csl css
    cp config/pandoc/*.$suffix ~/.local/share/pandoc/$suffix/
end

# 配置discord
cp ./config/discord/settings.json ~/.config/discord/

# 配置 imwheel
cp config/imwheel/imwheelrc ~/.imwheelrc

# 更新mime数据库
update-mime-database ~/.local/share/mime/

# 配置vncserver
cp ./config/vnc/vnc.cfg ~/.vnc/config
if type -q vncserver && confirm 'Do you want to configure vncserver?'
    vncpasswd
    vncserver
end

# 配置docker代理
if type -q docker && confirm 'Do you want to configure docker proxy?'
    mkdir -p ~/.docker/
    cp -b ./config/docker/config.json
end

# 添加自身到必需的组
if confirm 'Do you want to add yourself to some groups?'
    for group in shadow lpadmin mysql ssl-cert www-data staff adm systemd-journal wireshark docker kvm input uinput users lp sambashare
        sudo adduser $USER $group
    end
end
