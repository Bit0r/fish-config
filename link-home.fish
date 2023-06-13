#!/usr/bin/fish

function link-home -d "Link a directory from home to /usr/local/home" -a dir
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
