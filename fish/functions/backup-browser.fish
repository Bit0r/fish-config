function backup-browser -a browser -d "Backup browser configuration to a tarball"
    # 该函数用于备份浏览器配置文件
    # 用法：backup-browser [浏览器名称]
    # 默认备份 Vivaldi 浏览器的配置文件
    # 恢复备份文件：tar -xvf [浏览器名称].tzst -C ~/.config/

    if [ -z "$browser" ]
        set browser $BROWSER
    end
    if [ -z "$browser" ]
        set browser vivaldi
    end

    cd ~/.config/
    tar -cavf $browser.tzst $browser/{Default,Profile*}
    prevd

    mv ~/.config/$browser.tzst ./
end
