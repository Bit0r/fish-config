#!/usr/bin/fish

function link-home
    set dir $argv[1]

    /usr/local/$HOME/

    cp -r ~/$dir/ ./
    rm -rf ~/$dir/

    ln -s /usr/local/$HOME/$dir ~/
end

sudo mkdir /usr/local/home/

/usr/local/home/
sudo mkdir $USER
sudo chown $USER:$USER $USER

link-home .local
link-home .config
