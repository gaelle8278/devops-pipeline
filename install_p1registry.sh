#!/bin/bash

## install registry

IP=$(hostname -I | awk '{print $2}')

echo "=== START - Install registry - "$IP

echo "[1]: install utils"
apt-get update -qq >/dev/null
apt-get install -qq -y git wget curl gnupg2 >/dev/null

echo "[2]: install docker & docker-composer"
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg >/dev/null
echo  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update -qq >/dev/null
apt-get install -qq -y docker-ce docker-ce-cli containerd.io >/dev/null
curl -sL "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

echo "[3]: install registry"
mkdir certs/
openssl req -x509 -newkey rsa:4096 -nodes -keyout certs/myregistry.key -out certs/myregistry.crt -days 365 -subj /CN=myregistry.my
mkdir passwd/
docker run --entrypoint htpasswd registry:2 -Bbn gaelle gaelle > passwd/htpasswd

mkdir data/
echo "
version: '3.5'
services:
  registry:
    restart: always
    image: registry:2
    container_name: registry
    ports:
      - 5000:5000
    environment:
      REGISTRY_HTTP_TLS_CERTIFICATE: /certs/myregistry.crt
      REGISTRY_HTTP_TLS_KEY: /certs/myregistry.key
      REGISTRY_AUTH: htpasswd
      REGISTRY_AUTH_HTPASSWD_PATH: /auth/htpasswd
      REGISTRY_AUTH_HTPASSWD_REALM: Registry Realm
    volumes:
      - ./data:/var/lib/registry
      - ./certs:/certs
      - ./passwd:/auth
" > docker-compose-registry.yml

docker-compose -f docker-compose-registry.yml up -d

echo "=== END - install registry - "$IP

