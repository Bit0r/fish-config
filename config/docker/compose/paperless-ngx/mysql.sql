-- 创建数据库，如果不存在的话
-- 必须使用 utf8mb3 编码，否则会报错
CREATE DATABASE IF NOT EXISTS paperless CHARACTER SET utf8mb3;

-- 将密码级别设置为低
SET GLOBAL validate_password.policy = 'LOW';

-- 创建数据库用户并设置密码，如果用户已存在则更新密码
CREATE USER IF NOT EXISTS 'paperless'@'%' IDENTIFIED BY 'paperless';
ALTER USER 'paperless'@'%' IDENTIFIED BY 'paperless';

-- 将密码级别设置回来
SET GLOBAL validate_password.policy = 'MEDIUM';

-- 授予用户对数据库的所有权限
GRANT ALL PRIVILEGES ON paperless.* TO 'paperless'@'%';

-- 刷新权限
FLUSH PRIVILEGES;
