 lines (35 sloc)  1.4 KB
#!/bin/bash
echo "Bitte gib die Subdomnain für Portainer ein - Portainer läuft auf Port 9000"
read -p "Subdomain: " subdomain;
rm /etc/nginx/sites-enabled/$subdomain;
echo "server {" >> /etc/nginx/sites-enabled/$subdomain;
echo "server_name $subdomain;" >> /etc/nginx/sites-enabled/$subdomain;
echo "location / {" >> /etc/nginx/sites-enabled/$subdomain;
echo "proxy_pass      http://127.0.0.1:9000;" >> /etc/nginx/sites-enabled/$subdomain;
echo "}" >> /etc/nginx/sites-enabled/$subdomain;
echo "}" >> /etc/nginx/sites-enabled/$subdomain;
sudo certbot --nginx -d $subdomain;
pkill nginx;
systemctl start nginx;
docker volume create portainer_data;
docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce;
sudo systemctl start gitea;
systemctl stop nginx;
systemctl start nginx;
