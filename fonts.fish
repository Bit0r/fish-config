#!/usr/bin/fish

sudo apt install fontconfig

sudo mkdir -pm 1777 /usr/local/share/fonts/{a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z}

cp fonts/Sim*.ttf /usr/local/share/fonts/s/
cp fonts/Wingdings*.ttf /usr/local/share/fonts/w/
cp fonts/MTExtra.ttf /usr/local/share/fonts/m/
cp fonts/Symbol.ttf /usr/local/share/fonts/s/
cp fonts/仿宋_GB2312.ttf /usr/local/share/fonts/f/
cp fonts/楷体_GB2312.ttf /usr/local/share/fonts/k/
cp fonts/MicrosoftYaHei*.ttf /usr/local/share/fonts/m/
cp fonts/Deng*.ttf /usr/local/share/fonts/d/

fc-cache -fv

if type -q mplfonts
    sudo mplfonts init
end
