function setup-LiteLoaderQQNT -d 'Setup LiteLoaderQQNT'
    set app_path /opt/QQ/resources/app
    set LiteLoaderQQNT_path $app_path/LiteLoaderQQNT
    set plugins_path $LiteLoaderQQNT_path/plugins
    set app_launcher_path $app_path/app_launcher

    sudo chown -R :$USER $app_path
    sudo chmod -R g+w $app_path

    if [ -d $LiteLoaderQQNT_path ]
        cd $LiteLoaderQQNT_path
        git pull
        prevd
    else
        git clone --depth 1 https://github.com/LiteLoaderQQNT/LiteLoaderQQNT.git $LiteLoaderQQNT_path
    end

    proxy-aria2c -d $plugins_path https://github.com/ltxhhz/LL-plugin-list-viewer/releases/download/v1.2.1/list-viewer.zip
    unar -o $plugins_path $plugins_path/list-viewer.zip

    cd $app_launcher_path

    if rg -qF LiteLoaderQQNT index.js
        echo 'index.js 已经引入 LiteLoaderQQNT，跳过。'
    else
        echo 'require("../LiteLoaderQQNT");' >index.js.tmp
        cat index.js >>index.js.tmp
        sudo mv index.js.tmp index.js
        echo 'index.js 引入 LiteLoaderQQNT 完成。'
    end

    prevd
end
