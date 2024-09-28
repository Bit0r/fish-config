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

    if [ ! -d $plugins_path/list-viewer/ ]
        proxy-aria2c -d $plugins_path https://github.com/ltxhhz/LL-plugin-list-viewer/releases/download/v1.3.5/list-viewer.zip
        unar -o $plugins_path $plugins_path/list-viewer.zip
    end

    echo "require('$LiteLoaderQQNT_path')" >$app_launcher_path/LiteLoaderQQNT.js
    sd '"main":\s*".+"' '"main": "./app_launcher/LiteLoaderQQNT.js"' $app_path/package.json
end
