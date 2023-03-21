#!/bin/bash
echo "Bitte gib den Pfad ein, indem sich die index.html Datei befindet (z.B. /home/user/webseite)."
read -p "Pfad: " pfad;
echo "Bitte gib den Domainnamen ein, über den die Homepage erreichbar sein soll (z.B. schule.de)."
read -p "Domain: " subdomain;


rm /etc/nginx/sites-enabled/$subdomain;
echo "server {" >> /etc/nginx/sites-enabled/$subdomain;
echo "server_name $subdomain;" >> /etc/nginx/sites-enabled/$subdomain;
echo "root /var/www/html;" >> /etc/nginx/sites-enabled/$subdomain;
echo "index index.html index.htm index.nginx-debian.html;" >> /etc/nginx/sites-enabled/$subdomain;
echo "location / {" >> /etc/nginx/sites-enabled/$subdomain;
echo "try_files $uri $uri/ =404;" >> /etc/nginx/sites-enabled/$subdomain;
echo "}" >> /etc/nginx/sites-enabled/$subdomain;
echo "}" >> /etc/nginx/sites-enabled/$subdomain;
sudo certbot --nginx -d $subdomain;
pkill nginx;
systemctl stop nginx;
systemctl start nginx;
