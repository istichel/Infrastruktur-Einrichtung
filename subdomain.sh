#!/bin/bash
echo "Bitte gib die Subdomnain ein, die du einrichten möchtest (z.B. testserver.stichels.de)."
read -p "Subdomain: " subdomain;
echo "Bitte gib den Port, auf dem dein Projekt laufen wird, ein (z.B. 8080)."
read -p "Port: " port;
rm /etc/nginx/sites-enabled/$subdomain;
echo "server {" >> /etc/nginx/sites-enabled/$subdomain;
echo "server_name $subdomain;" >> /etc/nginx/sites-enabled/$subdomain;
echo "location / {" >> /etc/nginx/sites-enabled/$subdomain;
echo "proxy_pass      http://127.0.0.1:$port;" >> /etc/nginx/sites-enabled/$subdomain;
echo "}" >> /etc/nginx/sites-enabled/$subdomain;
echo "}" >> /etc/nginx/sites-enabled/$subdomain;
sudo certbot --nginx -d $subdomain;
systemctl restart nginx;
