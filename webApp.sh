#!/bin/bash
echo "Bitte gib die Subdomnain ein, die du für die Beispiel webApp eingerichtet hast."
read -p "Subdomain: " subdomain;
sed -i 's/webapp.stichels.de/$subdomain/g' Infrastruktur-Einrichtung/webApp/app.py
cd Infrastruktur-Einrichtung/webApp;
flask run;
