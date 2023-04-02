#!/bin/bash
echo "Bitte gib die Subdomnain für gitea ein."
read -p "Subdomain: " subdomain;
rm /etc/nginx/sites-enabled/$subdomain;
echo "server {" >> /etc/nginx/sites-enabled/$subdomain;
echo "server_name $subdomain;" >> /etc/nginx/sites-enabled/$subdomain;
echo "location / {" >> /etc/nginx/sites-enabled/$subdomain;
echo "proxy_pass      http://127.0.0.1:3000;" >> /etc/nginx/sites-enabled/$subdomain;
echo "}" >> /etc/nginx/sites-enabled/$subdomain;
echo "}" >> /etc/nginx/sites-enabled/$subdomain;
sudo certbot --nginx -d $subdomain;
pkill nginx;
systemctl start nginx;
sudo apt -y update;
sudo apt -y upgrade;
sudo apt install -y sqlite;
wget -O gitea https://dl.gitea.io/gitea/1.19.0/gitea-1.19.0-linux-amd64
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
cp /root/Infrastruktur-Einrichtung/gitea/gitea.service /etc/systemd/system/gitea.service
cp /root/Infrastruktur-Einrichtung/gitea/app.ini /etc/gitea/ 
sed -i s/GITEADOMAIN/$subdomain/g /etc/gitea/app.ini
sudo chmod 777 /etc/gitea/app.ini;
sudo systemctl enable gitea;
sudo systemctl start gitea;
systemctl stop nginx;
systemctl start nginx;
