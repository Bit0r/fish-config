if type -q apt && confirm 'Do you want to run mysql_secure_installation?'
    sudo mysql_secure_installation
end

read -P 'New superuser username: ' user
# 密码强度要符合要求，如果运行完成后无法登陆，则需要再次运行本脚本
read -sP 'New superuser password: ' password

# 如果要强制修改密码，则可参考
# https://superuser.com/questions/1837653

# Check if the user already exists
set -l sql_command "CREATE USER '$user'@'localhost' IDENTIFIED BY '$password'; \
	ALTER USER '$user'@'localhost' IDENTIFIED WITH caching_sha2_password BY '$password'; \
	GRANT ALL PRIVILEGES ON *.* TO '$user'@'localhost' WITH GRANT OPTION; \
	FLUSH PRIVILEGES;"
# Execute SQL command
echo $sql_command | sudo mysql -u root -p

mysql_config_editor set --user=$user --password
