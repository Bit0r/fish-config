-- 创建数据库
CREATE DATABASE paperless;

-- 创建数据库用户并设置密码
CREATE USER paperless WITH PASSWORD 'paperless';

-- 授予用户对数据库的所有权限
GRANT ALL PRIVILEGES ON DATABASE paperless TO paperless;
