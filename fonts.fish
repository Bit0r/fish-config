#!/usr/bin/fish

sudo chmod 1777 /usr/local/share/fonts

mkdir -p /usr/local/share/fonts/{sim,wingdings,fancy,gb2312,YaHei,Deng}/

cp fonts/Sim*.ttf /usr/local/share/fonts/sim/
cp fonts/Wingdings*.ttf /usr/local/share/fonts/wingdings/
cp fonts/{MTExtra, Symbol}.ttf /usr/local/share/fonts/fancy/
cp fonts/*_GB2312.ttf /usr/local/share/fonts/gb2312/
cp fonts/MicrosoftYaHei*.ttf /usr/local/share/fonts/YaHei/
cp fonts/Deng*.ttf /usr/local/share/fonts/Deng/

fc-cache -fv

if type -q mplfonts
    sudo mplfonts init
end
