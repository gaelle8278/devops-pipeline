#!/bin/bash

## ? Install p1jenkins

IP=$(hostname -I | awk '{print $2}')

echo "START - install jenkins - "$IP

echo "[1]: install utils"
apt-get update -qq >/dev/null
apt-get install -qq -y git sshpass wget gnupg2 curl ca-certificates lsb-release >/dev/null

echo "[2]: install ansible"
sudo sh -c 'echo deb http://ppa.launchpad.net/ansible/ansible/ubuntu focal main > /etc/apt/sources.list.d/ansible.list'
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367 >/dev/null
apt-get update -qq >/dev/null
apt-get install -qq -y ansible >/dev/null

echo "[3]: ansible custom"
sed -i 's/.*pipelining.*/pipelining = True/' /etc/ansible/ansible.cfg
sed -i 's/.*allow_world_readable_tmpfiles.*/allow_world_readable_tmpfiles = True/' /etc/ansible/ansible.cfg

echo "[4] install java"
#wget "https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.13%2B8/OpenJDK11U-jdk_x64_linux_hotspot_11.0.13_8.tar.gz"
#tar xzf OpenJDK11U-jdk_x64_linux_hotspot_11.0.13_8.tar.gz -C /opt/
#echo 'export PATH=/opt/jdk-11.0.13+8/bin:$PATH' >> ~/.bashrc
#source ~/.bashrc
# default jre uses openjdk
apt-get install -qq -y default-jre >/dev/null

echo "[5]: install jenkins"
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
apt-get update -qq >/dev/null
apt-get install -qq -y jenkins >/dev/null
systemctl enable jenkins
systemctl start jenkins

echo "[6]: install docker & docker-composer"
#curl -fsSL https://get.docker.com | sh; >/dev/null
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg >/dev/null
echo  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update -qq >/dev/null
apt-get install -qq -y docker-ce docker-ce-cli containerd.io >/dev/null
usermod -aG docker jenkins # authorize docker for jenkins user
curl -sL "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

echo "[7]: use registry without ssl"
echo "
{
 \"insecure-registries\" : [\"192.168.5.5:5000\"]
}
" >/etc/docker/daemon.json
systemctl daemon-reload
systemctl restart docker

echo "END - install jenkins"

