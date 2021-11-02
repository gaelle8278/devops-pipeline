#!/bin/bash

## install server postgres

IP=$(hostname -I | awk '{print $2}')

echo "=== START - Install MySQL - "$IP" ==="

echo "[1]: update system"
sudo apt-get update -qq >/dev/null


echo "[2]: install utils"
sudo apt-get install -qq -y vim git wget curl gnupg >/dev/null
sudo apt-get install -qq -y debconf-utils zsh htop libaio1 >/dev/null

echo "[3]: update system"
sudo apt-get update -qq >/dev/null

echo "[4]: add MySQL repo"
cd /tmp
wget -q -O mysql-apt-config_0.8.13-1_all.deb https://dev.mysql.com/get/mysql-apt-config_0.8.13-1_all.deb
export DEBIAN_FRONTEND="noninteractive"
echo mysql-apt-config mysql-apt-config/select-server select mysql-8.0 | sudo debconf-set-selections
sudo -E dpkg -i mysql-apt-config_0.8.13-1_all.deb

echo "[5]: install MySQL"
sudo apt-get update -qq >/dev/null
export DEBIAN_FRONTEND="noninteractive"
sudo debconf-set-selections <<< 'mysql-community-server mysql-community-server/root-pass password root'
sudo debconf-set-selections <<< 'mysql-community-server mysql-community-server/re-root-pass password root'
sudo -E apt-get install -y -qq mysql-community-server >/dev/null

echo "[6]: configure MySQL"
mysql -u root -proot -e 'USE mysql; UPDATE `user` SET `Host`="%" WHERE `User`="root" AND `Host`="localhost"; DELETE FROM `user` WHERE `Host` != "%" AND `User`="root"; FLUSH PRIVILEGES;'

echo "[7]: create databases"
mysql  -u root -proot -e "CREATE DATABASE dev /*\!40100 DEFAULT CHARACTER SET utf8 */;"
mysql  -u root -proot -e "CREATE DATABASE stage /*\!40100 DEFAULT CHARACTER SET utf8 */;"
mysql  -u root -proot -e "CREATE DATABASE prod /*\!40100 DEFAULT CHARACTER SET utf8 */;"
mysql  -u root -proot -e "CREATE USER vagrant@localhost IDENTIFIED BY 'vagarant';"
mysql  -u root -proot -e "GRANT ALL PRIVILEGES ON dev.* TO 'vagrant'@'localhost';"
mysql  -u root -proot -e "GRANT ALL PRIVILEGES ON stage.* TO 'vagrant'@'localhost';"
mysql  -u root -proot -e "GRANT ALL PRIVILEGES ON prod.* TO 'vagrant'@'localhost';"
mysql  -u root -proot -e "FLUSH PRIVILEGES;"

echo "[8]: open Mysql port in firewall"
sudo iptables -A INPUT -s 10.10.10.126 -p tcp --destination-port 3306 -j ACCEPT

echo "[9]: restart MySQL"
service mysql restart

echo "=== END - Install MySQL - "$IP" ==="