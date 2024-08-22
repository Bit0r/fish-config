#!/usr/bin/env fish
if [ ! -e /usr/local/bin/micromamba ]
    echo $ROOT_PASSWD | su -c 'ln -s /mnt/usr/local/bin/* /usr/local/bin/'
end

# 启动 ssh 服务
echo $ROOT_PASSWD | su -c 'mkdir -pm 755 /run/sshd'
# chmod 755 /run/sshd
echo $ROOT_PASSWD | su -c 'service ssh start'

# 启动 vnc 服务
vncserver -kill ':*'
vncserver

# 进入无限循环，保持容器运行
tail -f /dev/null
