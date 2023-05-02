sudo adduser --shell /usr/bin/fish steam

sudo add-apt-repository multiverse
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install steamcmd

sudo -i fish -u steam
mkdir steamcmd
ln -s /usr/games/steamcmd steamcmd/steamcmd.sh
exit
