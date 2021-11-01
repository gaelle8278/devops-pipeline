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

echo "[6]: create databases"

echo "[7]: configure MySQL"

echo "[8]: ouverture du port Mysql dans le pare-feu"
sudo iptables -A INPUT -s 10.10.10.126 -p tcp --destination-port 3306 -j ACCEPT

echo "[9]: restart MySQL"

echo "=== END - Install MySQL - "$IP" ==="