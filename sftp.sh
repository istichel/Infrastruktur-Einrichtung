#!/bin/bash
echo "Bitte gib den Benutzernamen für den SFTP Zugang ein..."
read -p "Benutzername: " sftpuser;
sudo apt install ssh;
echo "Match group sftp" >> /etc/nginx/sites-enabled/$subdomain;
echo "ChrootDirectory /home" >> /etc/nginx/sites-enabled/$subdomain;
echo "X11Forwarding no" >> /etc/nginx/sites-enabled/$subdomain;
echo "AllowTcpForwarding no" >> /etc/nginx/sites-enabled/$subdomain;
echo "ForceCommand internal-sftp" >> /etc/nginx/sites-enabled/$subdomain;
systemctl restart ssh;
sudo addgroup sftp;
sudo useradd -m $sftpuser -g sftp;
echo "**********************"
echo "****** ACHTUNG *******"
echo "**********************"
echo "Gleich muss das Kennwort für den angelegten Benutzer festgelegt werden...gut merken!"
sudo passwd $sftpuser;
sudo chmod 700 /home/$sftpuser/
