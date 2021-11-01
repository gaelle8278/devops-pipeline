#!/bin/bash

## install server postgres

IP=$(hostname -I | awk '{print $2}')

echo "=== START - Install Postgres - "$IP" ==="

echo "[1]: update system"
apt-get update -qq >/dev/null
echo "[2]: install utils"
apt-get install -qq -y vim git wget curl >/dev/null
echo "[3]: install postgres"
apt-get install -qq -y postgresql-13 >/dev/null
echo "[4]: create databases"
sudo -u postgres bash -c "psql -c \"CREATE USER vagrant WITH PASSWORD 'vagrant';\""
sudo -u postgres bash -c "psql -c \"CREATE DATABASE dev OWNER vagrant;\""
sudo -u postgres bash -c "psql -c \"CREATE DATABASE stage OWNER vagrant;\""
sudo -u postgres bash -c "psql -c \"CREATE DATABASE prod OWNER vagrant;\""
echo "[5]: configure postgres"
sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/13/main/postgresql.conf
sed -i "s/127.0.0.1\/32/0.0.0.0\/0/g" /etc/postgresql/13/main/pg_hba.conf
echo "[6]: restart postgres"
service postgresql restart

echo "=== END - Install Postgres - "$IP" ==="

