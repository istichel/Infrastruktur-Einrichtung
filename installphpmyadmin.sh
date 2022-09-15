#!/bin/bash
echo "Bitte gib die Subdomnain für gitea ein."
read -p "Subdomain: " subdomain;
rm /etc/nginx/sites-enabled/$subdomain;
echo "server {" >> /etc/nginx/sites-enabled/$subdomain;
echo "server_name $subdomain;" >> /etc/nginx/sites-enabled/$subdomain;
echo "location / {" >> /etc/nginx/sites-enabled/$subdomain;
echo "proxy_pass      http://127.0.0.1:8000;" >> /etc/nginx/sites-enabled/$subdomain;
echo "}" >> /etc/nginx/sites-enabled/$subdomain;
echo "}" >> /etc/nginx/sites-enabled/$subdomain;
sudo certbot --nginx -d $subdomain;
pkill nginx;
systemctl start nginx;
sudo apt -y update;
sudo apt -y install apache2 mysql-server;
sudo mysql_secure_installation;
sudo apt -y install php libapache2-mod-php php-mysql;
sudo apt -y install phpmyadmin php-mbstring php-zip php-gd php-json php-curl;
