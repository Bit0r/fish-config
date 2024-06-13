mysql_secure_installation

read -P 'New superuser username: ' user
read -sP 'New superuser password: ' password

echo "CREATE USER '$user'@'localhost' IDENTIFIED BY '$password'; \
	ALTER USER '$user'@'localhost' IDENTIFIED WITH mysql_native_password BY '$password'; \
	GRANT ALL PRIVILEGES ON *.* TO '$user'@'localhost'; \
	FLUSH PRIVILEGES;" | sudo mysql -u root

mysql_config_editor set --user=$user --password
