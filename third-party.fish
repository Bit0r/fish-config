#!/usr/bin/fish
source ./include/confirm.fish

if type -q pip && confirm 'Do you want to install user-level software using pip?'
    pip install -r pkglist/requirements.txt
end

if sudo which pip >/dev/null && confirm 'Do you want to install system-level software using pip?'
    sudo pip install -r pkglist/requirements-global.txt
end

if type -q pipx
end

if sudo which pipx >/dev/null
    for pkg in (cat ./pkglist/pipx-global.txt | grep -v '^#')
        sudo fish -c "pipx install $pkg"
    end
    for inject in (cat ./pkglist/pipx-inject-global.txt | grep -v '^#')
        sudo fish -c "pipx inject $inject"
    end
end

if type -q go
    go install github.com/davecheney/httpstat@latest
    go install github.com/shurcooL/markdownfmt@latest
end

if type -q fnm
    fnm install --lts
end

if type -q micromamba && confirm 'Do you want to install some software using micromamba?'
    micromamba create -n labelme python pyside2 pyqt labelme
    micromamba run -n labelme pip install -U labelme
end

if sudo which yarn >/dev/null
    sudo yarn global add (cat ./pkglist/yarn-global.txt | grep -v '^#')
else if type -q yarn
    yarn global add (cat ./pkglist/yarn-global.txt | grep -v '^#')
end

if type -q wine
    aria2c --conf-path=./config/aria2/aria2.conf \
        'https://mirrors.cernet.edu.cn/winehq/wine/wine-mono/8.0.0/wine-mono-8.0.0-x86.msi' \
        'https://mirrors.cernet.edu.cn/winehq/wine/wine-gecko/2.47.4/wine-gecko-2.47.4-x86_64.msi' \
        'https://mirrors.cernet.edu.cn/winehq/wine/wine-gecko/2.47.4/wine-gecko-2.47.4-x86.msi'
    wine msiexec /i ./wine-mono-8.0.0-x86.msi
    wine msiexec /i ./wine-gecko-2.47.4-x86_64.msi
    wine msiexec /i ./wine-gecko-2.47.4-x86.msi
end

if type -q aptss && confirm 'Do you want to install some software using spark-store?'
    sudo aptss install (cat ./pkglist/spark.txt | grep -v '^#')
end

#if ! type -q client
#    aria2c -d /tmp 'http://218.77.121.111/DownloadXml/ClientPkgs/64ac0526-0589-4ec9-9142-06db38ef3da2/HN-linux-clientV2-64.tar.gz'
#    sudo unar -o /opt /tmp/HN-linux-clientV2-64.tar.gz
#    sudo chmod -R 777 /opt/linux-clientV2.0-64/
#    sudo cp config/surfing /etc/cron.d/
#end
