#!/bin/bash
echo "Bitte gib den Benutzernamen für den SFTP Zugang ein..."
read -p "Benutzername: " sftpuser;
sudo useradd -m $sftpuser -g sftp;
echo "**********************"
echo "****** ACHTUNG *******"
echo "**********************"
echo "Gleich muss das Kennwort für den angelegten Benutzer festgelegt werden...gut merken!"
sudo passwd $sftpuser;
gpasswd -a www-data $sftpuser;
chmod -R g+x /home/$sftpuser;
sudo chmod 700 /home/$sftpuser/
