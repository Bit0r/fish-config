#!/usr/bin/fish

source include/confirm.fish

set python_site (python -m site --user-site)

# 创建目录
mkdir -p \
    ~/.{vnc,docker} \
    ~/paperless-ngx \
    ~/.config/{fish/conf.d,profile.d,git,bat,below,direnv,crontab-ui,aria2,clipcat,dive,pip,uv,tstruct,tabby,waveterm,ImageMagick,smplayer,keepassxc,matplotlib,discord,sqlfluff,ruff,biome,micro,macchina,bililive} \
    ~/.local/share/{applications,kservices5/ServiceMenus,mime/packages,konsole,fcitx5,pandoc/{defaults,csl,css,docx}} \
    ~/.local/state/{aria2,clipcat} \
    ~/.local/lib/portainer \
    ~/.wine/drive_c/users/$USER/AppData/Roaming/'Microsoft Games/Rise of Nations' \
    $python_site
mkdir -pm 700 ~/.ssh/controls

#rm ~/.local/share/user-places.xbel
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
# 该配置不需要任何软链接，只需要将 micromamba 能在 PATH 中找到即可

# 复制rc文件
cp -f config/.*rc ~/

# 配置 mimeapps 文件
touch ~/.config/mimeapps.list
ln -sf ~/.config/mimeapps.list ~/.local/share/applications/mimeapps.list

# 配置 bat
#cp ./config/bat/config ~/.config/bat/

# 配置 direnv
cp ./config/direnv/direnv.toml ~/.config/direnv/

# 配置 micro
cp ./config/micro/settings.json ~/.config/micro/

# 配置 macchina
cp ./config/macchina/macchina.toml ~/.config/macchina/

# 配置pip
#cp config/pip.conf ~/.config/pip/

# 配置 npm
cp ./config/javascript/.*rc ~/

# 配置 labelme
cp ./config/labelme/labelme.yaml ~/.labelmerc

# 配置 anylabeling
cp ./config/anylabeling/anylabeling.yaml ~/.anylabelingrc

# 配置 paperless-ngx
cp -a ./config/docker/compose/paperless-ngx/. ~/paperless-ngx/

# 配置 ImageMagick
#cp ./config/ImageMagick/policy-open.xml ~/.config/ImageMagick/
#ln -bs ~/.config/ImageMagick/policy-open.xml ~/.config/ImageMagick/policy.xml

# 配置ssh
if confirm 'Do you want to configure ssh?'
    cp --backup=t ./config/ssh/ssh.conf ~/.ssh/config
end

# 配置git
cp config/.gitconfig ~/.config/git/config

# 配置 dive
cp ./config/dive/*.yaml ~/.config/dive/

# 配置aria2
cp ./config/aria2/aria2.conf ~/.config/aria2/

# 配置 below
cp ./config/below/belowrc.toml ~/.config/below/belowrc

# 配置 hadolint
cp -R ./config/docker/hadolint/. ~/.config/

# 配置 clipcat
cp -a ./config/clipcat/. ~/.config/clipcat/

# 配置bililive
cp ./config/bililive/config.yaml ~/.config/bililive/

cp ./config/smplayer/smplayer.ini ~/.config/smplayer/
cp ./config/desktop/mat2.desktop ~/.local/share/kservices5/ServiceMenus/
cp config/keepassxc.ini ~/.config/keepassxc/

# 配置 sqlfluff
cp -a ./config/sqlfluff/. ~/.config/sqlfluff/

# 配置 biome
cp -a ./config/javascript/biome/. ~/.config/biome/

# 配置 ruff
cp -a ./config/python/ruff/. ~/.config/ruff/

# 配置 uv
cp ./config/python/uv/* ~/.config/uv/

if type -q python
    # 配置python
    cp ./config/python/usercustomize.py $python_site/
    # 配置pyforest
    python -m pyforest install_extensions
end
# 配置 matplotlib
cp -b ./config/python/matplotlib/* ~/.config/matplotlib/

# 配置pandoc
cp config/pandoc/*.yaml ~/.local/share/pandoc/defaults/
for suffix in csl css
    cp config/pandoc/*.$suffix ~/.local/share/pandoc/$suffix/
end

# 配置d2
cp -a ./config/d2/. ~/.config/d2/

# 配置 tabby
cp ./config/tabby/config.yaml ~/.config/tabby/

# 配置 waveterm
cp ./config/waveterm/settings.json ~/.config/waveterm/

# 配置 imwheel
cp config/imwheel/imwheelrc ~/.imwheelrc

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

# 配置 ksystemlog
cp /usr/share/applications/org.kde.ksystemlog.desktop ~/.local/share/applications/
sd '^X-KDE-SubstituteUID' '#X-KDE-SubstituteUID' ~/.local/share/applications/org.kde.ksystemlog.desktop

# 配置 wine
cp -a ./config/wine/rise2.ini ~/.wine/drive_c/users/$USER/AppData/Roaming/'Microsoft Games/Rise of Nations/'

# 配置浏览器
for browser in vivaldi-stable
    update-browser-desktop $browser
end
for browser in google-chrome microsoft-edge
    update-browser-desktop $browser $browser-stable
end

# 配置 discord
cp ./config/discord/settings.json ~/.config/discord/
cp /usr/share/applications/discord.desktop ~/.local/share/applications/
sd '^Exec=/usr/share/discord/Discord$' 'Exec=/usr/share/discord/Discord --proxy-server=socks5://localhost' ~/.local/share/applications/discord.desktop

# 更新 mime 数据库
update-mime-database ~/.local/share/mime/

# 配置vncserver
cp ./config/vnc/vnc.cfg ~/.vnc/config
if type -q vncserver && confirm 'Do you want to configure vncserver?'
    vncpasswd
    vncserver
end

# 配置 x0vncserver
if type -q x0vncserver && confirm 'Do you want to configure x0vncserver?'
    cp ./config/.xprofile ~/.xprofile
end

# 配置 docker 容器代理
if type -q docker && confirm 'Do you want to configure docker container proxy?'
    cp -b ./config/docker/config.json ~/.docker/
end

# 添加自身到必需的组
if confirm 'Do you want to add yourself to some groups?'
    for group in shadow lpadmin mysql postgres redis ssl-cert www-data staff adm systemd-journal whoopsie wireshark docker kvm input uinput users lp sambashare
        sudo adduser $USER $group
    end
end
