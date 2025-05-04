#!/usr/bin/env fish

read -P '新的超级用户用户名: ' user
read -sP '新的超级用户密码: ' password

# 构建 SQL 命令
set sql_command "CREATE USER $user WITH SUPERUSER PASSWORD '$password';"
# 执行 SQL 命令
echo $sql_command | sudo -u postgres psql

if [ $status -eq 0 ]
    echo "用户 $user 创建成功。"
    echo "localhost:5432:*:$user:$password" >>~/.pgpass
    chmod 600 ~/.pgpass
else
    echo "创建用户 $user 失败。请检查错误消息和您的 PostgreSQL 配置。"
end
