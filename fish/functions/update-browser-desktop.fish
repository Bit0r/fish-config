function update-browser-desktop -a desktop_stem bin_name debug_port -d 'Update desktop entry'
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

    # 如果没有bin_name，则设为desktop_stem
    if [ -z $bin_name ]
        set bin_name $desktop_stem
    end

    # 更新.desktop文件
    sd "^Exec=/usr/bin/$bin_name %U\$" \
        "Exec=/usr/bin/$bin_name $proxy_arg $debug_arg $args %U" \
        $desktop_path
    # 隐私模式
    sd "^Exec=/usr/bin/$bin_name --incognito\$" \
        "Exec=/usr/bin/$bin_name --incognito $proxy_arg $debug_arg $args" \
        $desktop_path
end
