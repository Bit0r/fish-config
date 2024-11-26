#!/usr/bin/fish
source ./include/confirm.fish

if confirm 'Do you want to install some software from ppa?'
    sudo apt -m install (cat ./pkglist/ppa.txt | grep -v '^#')
end

if type -q gcc && type -q make && confirm 'Do you want to install git-credential-libsecret?'
    set libsecret_path /usr/share/doc/git/contrib/credential/libsecret/
    sudo make -C $libsecret_path
    sudo ln -s $libsecret_path/git-credential-libsecret /usr/local/bin/
end

if type -q aptss && confirm 'Do you want to install some software using spark-store?'
    sudo aptss install -m (cat ./pkglist/spark.txt | grep -v '^#')
end

if sudo which pip >/dev/null && confirm 'Do you want to install system-level software using pip?'
    sudo pip install -r pkglist/requirements-system.txt
end

if type -q pip && confirm 'Do you want to install user-level software using pip?'
    pip install -r pkglist/requirements-user.txt
end

if sudo which pipx >/dev/null && confirm 'Do you want to install system-level software using pipx?'
    for pkg in (cat ./pkglist/pipx-system.txt | grep -v '^#')
        sudo fish -c "pipx install $pkg"
    end
    for inject in (cat ./pkglist/pipx-inject-system.txt | grep -v '^#')
        sudo fish -c "pipx inject $inject"
    end
end

if type -q micromamba && confirm 'Do you want to install some software using micromamba?'
    # micromamba create -n labelme python pyside2 pyqt
    # micromamba run -n labelme pip install -U labelme
    micromamba create -n anylabeling python=3.10
    micromamba run -n anylabeling pip install -U anylabeling-gpu
end

if type -q fnm && confirm 'Do you want to install some software using fnm?'
    fnm install --lts
end

if sudo which ni >/dev/null && confirm 'Do you want to install some system-level software using ni?'
    sudo ni -g (cat ./pkglist/npm-global.txt | grep -v '^#')
else if type -q ni && confirm 'Do you want to install some user-level software using ni?'
    ni -g (cat ./pkglist/npm-global.txt | grep -v '^#')
end

if type -q go && confirm 'Do you want to install some software using go?'
    go install github.com/davecheney/httpstat@latest
    go install github.com/shurcooL/markdownfmt@latest
end

if type -q xcaddy && confirm 'Do you want to install caddy using xcaddy?'
    set -e args
    for plugin in (cat ./pkglist/caddy-plugins.txt | grep -v '^#')
        set -a args --with github.com/$plugin
    end
    xcaddy build $args
    install caddy
end

if type -q wine && confirm 'Do you want to install some software using wine?'
    aria2c --conf-path=./config/aria2/aria2.conf \
        'https://unicom.mirrors.ustc.edu.cn/wine/wine/wine-mono/9.1.0/wine-mono-9.1.0-x86.msi' \
        'https://mirrors.cernet.edu.cn/winehq/wine/wine-gecko/2.47.4/wine-gecko-2.47.4-x86_64.msi' \
        'https://mirrors.cernet.edu.cn/winehq/wine/wine-gecko/2.47.4/wine-gecko-2.47.4-x86.msi'
    wine msiexec /i ./wine-mono-9.1.0-x86.msi
    wine msiexec /i ./wine-gecko-2.47.4-x86_64.msi
    wine msiexec /i ./wine-gecko-2.47.4-x86.msi
end

#if ! type -q client
#    aria2c -d /tmp 'http://218.77.121.111/DownloadXml/ClientPkgs/64ac0526-0589-4ec9-9142-06db38ef3da2/HN-linux-clientV2-64.tar.gz'
#    sudo unar -o /opt /tmp/HN-linux-clientV2-64.tar.gz
#    sudo chmod -R 777 /opt/linux-clientV2.0-64/
#    sudo cp config/surfing /etc/cron.d/
#end
