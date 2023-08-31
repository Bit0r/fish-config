#!/usr/bin/fish

sudo mkdir -p /usr/local/share/fonts/{sim, wingdings, fancy, gb2312}/

sudo cp fonts/Sim*.ttf /usr/local/share/fonts/sim/
sudo cp fonts/Wingdings*.ttf /usr/local/share/fonts/wingdings/
sudo cp fonts/{MTExtra, Symbol}.ttf /usr/local/share/fonts/fancy/
sudo cp fonts/*_GB2312.ttf /usr/local/share/fonts/gb2312/

fc-cache -f -v

if type -q mplfonts
    sudo mplfonts init
end
