#!/bin/bash  
echo "Bitte die Hinweise im Git-Repository beachten!"
sudo apt update;
sudo apt upgrade;
sudo apt install -y git;
sudo apt install -y nginx;
sudo apt install -y python3;
sudo apt install -y certbot;
sudo apt install -y python-certbot-nginx;
sudo apt install -y ruby;
sudo apt install -y default-jdk;
sudo apt install -y default-jre;
sudo apt install -y python3-pip;
sudo pip install -y flask;
sudo shutdown -r now;
