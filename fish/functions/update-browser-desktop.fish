function update-browser-desktop -a desktop_stem debug_port -d 'Update desktop entry'
    set desktop_path /usr/share/applications/$desktop_stem.desktop
    # 如果.desktop文件不存在则跳过
    if [ ! -f $desktop_path ]
        return
    end
    cp $desktop_path ~/.local/share/applications/

    # 更新.desktop文件路径
    set desktop_path ~/.local/share/applications/$desktop_stem.desktop

    # 设置args
    set args '--allow-running-insecure-content --allow-outdated-plugins --allow-scripting-gallery --silent-debugger-extension-api'
    set proxy_arg '--proxy-server=socks5://localhost'
    set debug_arg '--remote-debugging-port='$debug_port

    # 更新.desktop文件
    sd '^Exec=/usr/bin/([\w\-]+) (%\w)$' \
        "Exec=/usr/bin/\$1 $proxy_arg $debug_arg $args \$2" \
        $desktop_path
    # 隐私模式
    sd '^Exec=/usr/bin/([\w\-]+) --incognito$' \
        "Exec=/usr/bin/\$1 $proxy_arg $debug_arg $args --incognito" \
        $desktop_path
end
