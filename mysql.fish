# mysql_secure_installation
read -P 'Enter user: ' user
read -sP 'Enter password: ' password

echo "CREATE USER '$user'@'localhost' IDENTIFIED BY '$password'; \
	GRANT ALL PRIVILEGES ON *.* TO '$user'@'localhost'; \
	FLUSH PRIVILEGES;" | sudo mysql -u root

mysql_config_editor set --user=$user --password
