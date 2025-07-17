# 将 redis 和 mysql 的地址绑定到 0.0.0.0，以便 docker 容器访问
sd '^bind' '#bind' /etc/redis/redis.conf
sd '^protected-mode yes' 'protected-mode no' /etc/redis/redis.conf
sd '^bind-address' '#bind-address' /etc/mysql/mysql.conf.d/mysqld.cnf

# 创建数据库
sudo mysql <mysql.sql
