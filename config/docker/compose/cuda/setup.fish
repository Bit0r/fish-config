#!/usr/bin/env fish
if [ ! -e /usr/local/bin/micromamba ]
    ln -s /mnt/usr/local/bin/* /usr/local/bin/
end

# 启动 ssh 服务
cat ./passwd.usv | chpasswd
mkdir -p /run/sshd
chown root:root /run/sshd
chmod 755 /run/sshd
service ssh start

# 启动 vnc 服务
vncserver -kill ':*'
vncserver

# 进入无限循环，保持容器运行
tail -f /dev/null
