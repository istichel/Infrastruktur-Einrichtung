#!/bin/bash
echo "Bitte die Hinweise im Git-Repository beachten!"
sudo apt update -y;
sudo apt upgrade -y;
sudo apt install -y git;
sudo apt install -y nginx;
sudo apt install -y python3;
sudo apt install -y certbot;
sudo apt install -y python3-certbot-nginx;
sudo apt install -y ruby;
sudo apt install -y default-jdk;
sudo apt install -y default-jre;
sudo apt install -y python3-pip;
sudo apt install -y net-tools;
pip install flask;
git clone https://github.com/istichel/Infrastruktur-Einrichtung.git;
sudo shutdown -r now;
