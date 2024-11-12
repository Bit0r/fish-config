sudo mount /dev/nvme0n1p1 /mnt
sudo mount /dev/sda1 /mnt/data

# 复制固态硬盘上的文件到机械硬盘
sudo cp -a /mnt/{home,var,usr/local,opt,snap,srv,game} /mnt/data/

# 修改 fstab 文件
python fstab.py --fstab_dir ./config/fstab.d/ write_fstab /mnt/etc/fstab

sudo umount /mnt/data
sudo umount /mnt
