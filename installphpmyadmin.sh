#!/bin/bash
echo "Bitte gib die Subdomnain für phpmyadmin ein."
read -p "Subdomain: " subdomain;
echo "Bitte gib das Kennwort für mysql ein."
read -p "Kennwort: " password;
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
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$password';"
sudo mysql_secure_installation;
sed -i s/80/81/g /etc/apache2/ports.conf;
sed -i s/443/444/g /etc/apache2/ports.conf;
sed -i s/'/var/www/html'/'/var/www/html/phpmyadmin'/g /etc/apache2/ports.conf;
sudo apt -y install php libapache2-mod-php php-mysql;
sudo apt -y install phpmyadmin php-mbstring php-zip php-gd php-json php-curl;
