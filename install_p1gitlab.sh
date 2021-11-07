#!/bin/bash


IP=$(hostname -I | awk '{print $2}')

echo "=== START - Install gitlab - "$IP

echo "[1]: Install utils"
apt-get update -qq >/dev/null
apt-get install -qq -y vim git wget curl openssh-server ca-certificates perl >/dev/null

echo "[2]: Add repository"
curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.deb.sh | sudo bash
apt-get update -qq >/dev/null

echo "[3]: Install Gitlab"
export GITLAB_URL="http://gitlab.kiwiland.lan"
touch /tmp/gitlab_install.log
sudo EXTERNAL_URL="${GITLAB_URL}" GITLAB_ROOT_PASSWORD="rootroot" apt-get install -qq -y gitlab-ee > /tmp/gitlab_install.log
# in case installation doesn't do the reconfigure because of the fake hostname
touch /tmp/gitlab_reconfigure.log
sudo GITLAB_ROOT_PASSWORD="rootroot" gitlab-ctl reconfigure > /tmp/gitlab_reconfigure.log

echo "=== END - Install gitlab - "$IP

# TODO ajout postifx installation
# postfix est en mode interactif donc faire comme pour l'installation de MySQL = utiliser debconf-set-selections pour enregistrer les réponses



