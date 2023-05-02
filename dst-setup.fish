#!/usr/bin/fish

#sudo apt install ufw
#sudo ufw limit ssh
#sudo ufw enable
source steam-setup.fish

sudo apt install aria2

sudo -i fish -u steam
aria2c https://accounts.klei.com/assets/gamesetup/linux/run_dedicated_servers.sh
chmod u+x ./run_dedicated_servers.sh
exit

sudo cp config/dst.service /etc/systemd/system/
sudo cp config/dst.conf /etc/rsyslog.d/
