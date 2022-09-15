#!/bin/bash
echo "Bitte gib die Subdomnain für phpmyadmin ein."
read -p "Subdomain: " subdomain;
rm /etc/nginx/sites-enabled/$subdomain;
echo "server {" >> /etc/nginx/sites-enabled/$subdomain;
echo "server_name $subdomain;" >> /etc/nginx/sites-enabled/$subdomain;
echo "location / {" >> /etc/nginx/sites-enabled/$subdomain;
echo "proxy_pass      http://127.0.0.1:81;" >> /etc/nginx/sites-enabled/$subdomain;
echo "proxy_set_header X-Forwarded-Proto https;" >> /etc/nginx/sites-enabled/$subdomain;
echo "}" >> /etc/nginx/sites-enabled/$subdomain;
echo "}" >> /etc/nginx/sites-enabled/$subdomain;
sudo certbot --nginx -d $subdomain;
pkill nginx;
systemctl start nginx;
sudo apt -y update;
sudo apt -y install apache2 mysql-server;
echo "Bitte gib das Kennwort für mysql ein - dieses muss gleich noch einmal eingegeben werden!"
read -p "Kennwort: " password;
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$password';"
sudo mysql_secure_installation;
sed -i s/80/81/g /etc/apache2/ports.conf;
sed -i s/443/444/g /etc/apache2/ports.conf;
sed -i s/'\/var\/www\/html'/'\/var\/www\/html\/phpmyadmin'/g /etc/apache2/sites-enabled/000-default.conf;
sed -i s/'#ServerName www.example.com'/'ServerName $subdomain'/g /etc/apache2/sites-enabled/000-default.conf;
sed -i s/80/81/g /etc/apache2/sites-enabled/000-default.conf;
sudo apt -y install php libapache2-mod-php php-mysql;
sudo apt -y install phpmyadmin php-mbstring php-zip php-gd php-json php-curl;
systemctl stop apache2;
systemctl start apache2;

