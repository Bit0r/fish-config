mysql_secure_installation

read -P 'New superuser username: ' user
read -sP 'New superuser password: ' password

# Check if the user already exists
set -l sql_command "CREATE USER '$user'@'localhost' IDENTIFIED BY '$password'; \
	ALTER USER '$user'@'localhost' IDENTIFIED WITH mysql_native_password BY '$password'; \
	GRANT ALL PRIVILEGES ON *.* TO '$user'@'localhost'; \
	FLUSH PRIVILEGES;"
# Execute SQL command
echo $sql_command | sudo mysql -u root -p

mysql_config_editor set --user=$user --password
