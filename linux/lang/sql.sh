yay -S --noconfirm --needed mariadb
sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
sudo systemctl enable mariadb.service
sudo systemctl start mariadb.service
sudo chown -R mysql:mysql /var/lib/mysql
sudo chmod -R +777 /var/lib/mysql
