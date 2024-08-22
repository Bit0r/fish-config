#!/usr/bin/env fish

# 设置文件目录
set usv_dir /root

# 修改root密码
echo root:$ROOT_PASSWD | chpasswd

# 创建用户
newusers $usv_dir/users.usv

# 从user.usv中获取用户列表
set users (cut -d: -f1 $usv_dir/users.usv)
set extra_groups www-data staff adm input lp users dialout cdrom floppy audio video plugdev games
# 将groups列表join为字符串
set extra_groups (string join ',' $extra_groups)

# 为每个用户添加额外的组
for user in $users
    usermod -aG $extra_groups $user
end
