sudo mount /dev/nvme0n1p1 /mnt
sudo mount /dev/sda1 /mnt/data

/mnt/

sudo cp -a ./{home,var,usr/local,opt,game,srv} /mnt/data/

python fstab.py /etc/fstab

~

sudo umount /mnt/data
sudo umount /mnt
