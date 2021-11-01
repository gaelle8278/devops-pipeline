#!/bin/bash

echo "=== Start ssh config "$IP" ==="

echo "[1] adapt ssh config"
sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config
sed -i 's/#.*PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
service ssh restart

echo "[2] change vagrant password"
echo 'vagrant:vagrant' | sudo chpasswd # change user vagrant password to vagrant


echo "=== End ssh config - "$IP" ==="