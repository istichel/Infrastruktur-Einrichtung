# Infrastruktureinrichtung für den Informatik-Unterricht
Guter Informatik-Unterricht zeichnet sich dadurch aus, dass Schülerinnen und Schüler die Möglichkeiten haben echte kleine Projekte zu realisieren und die Projekte online stellen können.
In diesem git-Repository findet ihr alles, was es für den Aufbau einer rudimentären Infrastruktur braucht.

## Voraussetzungen
* SSH-Zugriff auf einen Ubuntu Server 22.04 LTS mit mind. 2 Cores, 2GB Arbeitsspeicher, 20GB Festplatte
* Erreichbarkeit des Servers innerhalb und außerhalb der Schule (externes Hosting bei einem Hostinganbieter erleichtert den Zugriff) 
* Zugriff auf den Verwaltungsbereich des Hosting-Anbieters

(Hinweis: SSH Zugriff auf externe Server ist innerhalb der Schule oft gesperrt. Eine Konsole kann man über den Verwaltungsbereich des Hosting-Anbieters bekommen. So kann auch innerhalb der Schule der Server administriert werden.)

## Erstmaliges Einrichten des Servers
Zunächst sollen auf dem Server rudimentäre Programme installiert werden und alle aktuellen updates eingespielt werden. Gehe dazu wie folgt vor:
* Verbinde dich per SSH auf deinen Server (Befehl: ssh root@IP-Adresse), anschließend mit "yes" bestätigen und das Kennwort eingeben. (Beim Eingeben des Kennworts bewegt sich der Text-Kursor nicht. Das ist normal!)
* Gib folgenden Befehl ein und bestätige mit der Enter-Taste:\
  wget -O - https://raw.githubusercontent.com/istichel/Infrastruktur-Einrichtung/main/install.sh | bash\
  => Der Vorgang kann ein Wenig dauern. Nach dem Vorgang wird der Server neu gestartet und man kann sich nach wenigen Minuten wieder per SSH verbinden.
 * Nach der Installation sind im Verzeichnis Infrastruktur-Einrichtung weitere Dateien, die bei der weiteren Einrichtung helfen können.

## Einrichtung einer webApp
Um eine webApp einzurichten, sind folgende Schritte zu absolvieren:
* Subdomain anlegen (im Verwaltungsbereich des Hosting Anbieters) und Verwendungsart prüfen (ggf. einstellen)
* Mit folgendem Befehl ein SSL Zertifikat bei letsEncrypt beschaffen und den Reverse Proxy konfigurieren: \
  bash Infrastruktur-Einrichtung/subdomain.sh \
  Die Anweisungen befolgen, d.h. Subdomain eingeben, Port eingeben, Email-Adresse eingeben (Dummy-Adresse geht auch),Y,N
* webApp starten, sie sollte über den Browser erreichbar sein.\
(Die mitgelieferte webApp verwendet den Port 5000 und wird mit dem Befehl "bash Infrastruktur-Einrichtung/webApp.sh" gestartet.)

## Onlinestellen eines Schülerprojekts
### Subdomain erstellen
Um ein Schülerprojekt online zu stellen, muss zunächst im Verwaltungsbereich des Hosting Anbieters eine Subdomain angelegt werden. \
Bei IONOS klickt man dazu nach dem Login auf \
DOMAIN & SSL => Subdomain erstellen (auf der rechten Seite unter Häufig genutzt Funktionen) => Subdomainnamen eingeben (z.B. projekt1) => speichern.\
IONOS stellt die Domain automatisch richtig ein, wenn nur ein Server gebucht ist. Um sicher zu gehen, sollte man dennoch prüfen, ob die Domain eine Weiterleitung zum Server hat. Dazu geht man wieder auf DOMAIN & SSL \
=> klickt seine Subdomain an => Reiter Subdomains => sucht die neu erstellte Subdomain aus und klickt auf das Zahnrad => Verwendungsart anpassen => DNS
Hier muss nun ein Eintrag mit dem Typ A und der IP Adresse des Servers sein. Sollte dieser fehlen => Record hinzufügen => A => IP Adresse des Servers hinterlegen => Speichern
### NGINX das neue Projekt mitteilen
NGINX ist auf dem Server installiert und leitet Anfragen, die beim Server ankommen an die entsprechenden Programme weiter. Hat man also eine neue Subdomain erstellt, muss man NGINX sagen, was mit Anfragen auf diese Subdomain passieren soll. Dazu muss man wissen, auf welchem Port das Schülerprojekt läuft. Ist der Port bekannt, kann man mit dem Befehl: \
bash Infrastruktur-Einrichtung/subdomain.sh \
alle notwendigen einstellungen vornehmen.
### Schülerprojekt starten
Ist die Subdomain eingestellt und NGINX konfiguriert muss das Schülerprojekt nur noch gestartet werden. Sobald das Projekt läuft, kann man direkt darauf zugreien. 
Möchte man, dass das Schülerprojekt dauerhaft läuft, so kann man den startbefehl am Anfang um "nohup" und am Ende um "&" ergänzen. Der Befehl könnte dann z.B. so aussehen:\
nohup ruby projekt.rb &
Da man den Port des Projekts kennt, kann man ein dauerhaft laufendes Programm mit kill 'lsof -t -i:9001' beenden. Hierbei ist 9001 die Portnummer auf der das Projekt läuft.   
### Troubleshooting - auf ein Schülerprojekt kann nicht zugegriffen werden
Hat man alles eingerichtet und das Projekt ist einfach nicht online sollte man wie folgt vorgehen:
* Subdomain einstellungen prüfen
* NGINX prüfen (läuft es überhaupt - siehe Cheat Sheet)
* NGINX neu starten (siehe Cheat Sheet)
* Schülerprojekt bei NGINX bekannt machen
* Schülerprojekt prüfen
## Cheat Sheet - Befehle im Terminal
Befehl oder Tasten           | Erklärung 
---------------------------- | ----------------------- 
ls                           | Zeigt alle Dateien im aktuellen Verzeichnis an.
pwd                          | Zeigt das aktuelle Verzeichnis an.
cd verzeichnisName           | Wechselt in das angegebene Verzeichnis.
exit                         | Trennt die Verbindung zum Server.
STRG+c                       | Beendet das aktuell laufende Programm
kill 'lsof -t -i:9001'       | Beendet den Prozess an Port 9001
systemctl status nginx       | gibt den Status von NGINX an. NGINX läuft richtig, wenn der Status "running" ist.
systemctl stop nginx         | Beendet NGINX.
systemctl start nginx        | Startet NGINX.
systemctl reload nginx       | Startet NGINX neu.
