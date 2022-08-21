#!/bin/bash
echo "Bitte gib die Subdomnain ein, die du einrichten möchtest (z.B. testserver.stichels.de)."
read -p "Subdomain: " subdomain;
sudo certbot --nginx -d $subdomain;
systemctl restart nginx;
