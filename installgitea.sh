#!/bin/bash
sudo apt update;
sudo apt upgrade;
sudo apt install sqlite;
wget -O gitea https://dl.gitea.io/gitea/1.17.1/gitea-1.17.1-linux-amd64
chmod +x gitea;
adduser --system --shell /bin/bash --gecos 'Git Version Control' --group --disabled-password --home /home/git git;
mkdir -p /var/lib/gitea/{custom,data,log};
chown -R git:git /var/lib/gitea/;
chmod -R 750 /var/lib/gitea/;
mkdir /etc/gitea;
chown root:git /etc/gitea
chmod 770 /etc/gitea
export GITEA_WORK_DIR=/var/lib/gitea/
cp gitea /usr/local/bin/gitea
cp /root/Infrastruktur-Einrichtung/gitea.service /etc/systemd/system/gitea.service 
sed s/8080/999/g /etc/gitea/app.ini
sudo chmod 777 /etc/gitea/app.ini;
sudo systemctl enable gitea;
sudo systemctl start gitea;

