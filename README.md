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

## Einrichtung gitea
Voraussetzungen:
* Port 3000 darf noch nicht in Benutzung sein.
* Subdomain für gitea muss im Verwaltungsbereich des Hostinganbieters eingerichtet sein
* erstmalige Einrichtung des Servers ist abgeschlossen
* Zugriff auf einen Email-Dienst, der mit gitea verbunden wird (optional)

Sind die Voraussetzungen erfüllt, loggt man sich per SSH ein und installiert gitea mit dem Befehl

cd; cd Infrastruktur-Einrichtung; git pull; cd; bash Infrastruktur-Einrichtung/installgitea.sh

Zunächst wird man aufgefordert die Domain für gitea eingerichtete Domain einzugeben. Das ist notwendig, damit das SSL Zertifikat und NGINX direkt richtig eingestellt werden können.

Falls man zum ersten Mal eine Subdomain anlegt, beantwortet man die folgenden Fragen wie folgt:
* Email-Adresse eingeben (falls man zum ersten mal eine Subdomain anlegt)
* Y (Nutzungsbedingungen letsencrypt)
* N (Newsletter letsencrypt)

Nach der Installation kann mit dem Befehl

systemctl status gitea

geprüft werden, ob gitea läuft. Aus der Ansicht kommt man durch Drücken der Taste "q" wieder raus.

Schließlich öffnet man einen Browser und ruft gitea auf. (z.B.: https://gitea.meinedomain.de) => Registrieren => Konto anlegen. 
Wichtiger Hinweis: Das erste Konto, das angelegt wird, ist auch gleichzeitig das Admin Konto. 
Wichtiger Hinweis: Der Benutzername "admin" ist für interne Zwecke reserviert und darf (auch für das erste Konto) nicht verwendet werden. Ich empfehle euer Kürzel zu verwenden.

Nach dem Anlegen des Admin Kontos, sollte man noch einen Email-Versand einrichten, damit vergessene Kennwörter selbstständig zurückgesetzt werden können.
Dazu benötigt man einen Email-Dienst und folgende Infos: SMTP Server, SMTP Port, Nutzername, Email
Diese erhält man in der Regel durch einfaches googeln (z.B. für IONOS: https://www.ionos.de/hilfe/e-mail/allgemeine-themen/serverinformationen-fuer-imap-pop-und-smtp/)

Mit folgendem Befehl kann man den Email-Dienst für gitea hinterlegen:

cd; cd Infrastruktur-Einrichtung; git pull; cd; bash Infrastruktur-Einrichtung/setgiteaemail.sh

Dabei muss man die oben genannten Infos eingeben. Die Email-Konfiguration sollte man testen, dazu loggt man sich mit dem Admin-Account bei gitea ein => klickt oben rechts auf den Avatar => Administration => Reiter Konfiguration => nach untenscrollen und eine Testmail verschicken. 
Wenn alles richtig eingestellt ist, kommt die Testmail an. Ansonsten kann man die Email-Konfiguration ohne Weiteres neu probieren.

## Einrichtung mysql und phpmyadmin
Die Einrichtung von phpmyadmin ist etwas komplizierter - aber auch kein Hexenwerk. 
Voraussetzungen:
* Port 81 und 444 darf noch nicht in Benutzung sein.
* Subdomain für phpmyadmin muss im Verwaltungsbereich des Hostinganbieters eingerichtet sein
* erstmalige Einrichtung des Servers ist abgeschlossen
Sind die Voraussetzungen erfüllt, loggt man sich per SSH ein und installiert mysql und phpmyadmin mit dem Befehl

cd; cd Infrastruktur-Einrichtung; git pull; cd; bash Infrastruktur-Einrichtung/installphpmyadmin.sh

Während der Installation wird man immer wieder aufgefordert, verschiedene Sachen einzugeben:
* Subdomain eingeben (falls man gefragt wird, dann die option "Redirect" auswählen)
* Email-Adresse eingeben (falls man zum ersten mal eine Subdomain anlegt)
* Y (Nutzungsbedingungen letsencrypt) (falls man zum ersten mal eine Subdomain anlegt)
* N (Newsletter letsencrypt) (falls man zum ersten mal eine Subdomain anlegt)
* Root Kennwort für mysql wählen (und unbedingt notieren) 
* Root Kennwort für mysql noch einmal eingeben 
* no (Validate Password Component) 
* no (Change the passwort for root) 
* y (Remove anonymous users) 
* y (disallow root login remotely) 
* y (remove test database and access to it) 
* y (Reload privilege tables nows)
* im auftauchenden farbenfrohen Fenster apache2 auswählen (mit der Leertaste, es muss ein Stern bei apache2 auftauchen => Tab Taste drücken um auf den OK Button zu kommen => Enter drücken zum Bestätigen)
* im neuen farbenfrohen Fenster: yes (Configure database for phpmyadmin with dbconfig-common) 
* nichts eingeben und einfach mit Enter bestätigen (MySQL Application Password for phpmyadmin)

Nach der Installation lohnt es sich zu prüfen ob nginx und apache2 laufen => man gibt ein:

systemctl status nginx (es muss in grün "running" stehen -> Ansonsten nginx neu starten (siehe Cheat Sheet)
systemctl status apache2 (es muss in grün "running" stehen -> Ansonsten apache2 neu starten (siehe Cheat Sheet)

Ist die Installation durchgelaufen, kann man unter der angegeben Domain phpmyAdmin aufrufen und sich mit den Benutzerdaten root und dem mysql root Kennwort einloggen. Es empfiehlt sich zunächst ein paar Benutzer zu erstellen, so dass die Schülerinnen und Schüler nicht mit dem root Nutzer arbeiten. => Fortbildung Basiswissen Datenbanken (INF0086)

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
IONOS stellt die Domain automatisch richtig ein, wenn nur ein Server gebucht ist. Um sicher zu gehen, sollte man dennoch prüfen, ob die Domain eine Weiterleitung zum Server hat. \
Dazu geht man wieder auf DOMAIN & SSL => klickt seine Subdomain an => Reiter Subdomains => sucht die neu erstellte Subdomain aus und klickt auf das Zahnrad => Verwendungsart anpassen => DNS
Hier muss nun ein Eintrag mit dem Typ A und der IP Adresse des Servers sein. Sollte dieser fehlen => Record hinzufügen => A => IP Adresse des Servers hinterlegen => Speichern
### NGINX das neue Projekt mitteilen
NGINX ist auf dem Server installiert und leitet Anfragen, die beim Server ankommen an die entsprechenden Programme weiter. Hat man also eine neue Subdomain erstellt, muss man NGINX sagen, was mit Anfragen auf diese Subdomain passieren soll. Dazu muss man wissen, auf welchem Port das Schülerprojekt läuft. Ist der Port bekannt, kann man mit dem Befehl: 

bash Infrastruktur-Einrichtung/subdomain.sh 

alle notwendigen einstellungen vornehmen.
### Schülerprojekt starten
Ist die Subdomain eingestellt und NGINX konfiguriert muss das Schülerprojekt nur noch gestartet werden. Sobald das Projekt läuft, kann man direkt darauf zugreien. 
Möchte man, dass das Schülerprojekt dauerhaft läuft, so kann man den startbefehl am Anfang um "nohup" und am Ende um "&" ergänzen. Der Befehl könnte dann z.B. so aussehen:

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
systemctl reload nginx       | Startet NGINX.
systemctl start apache2      | Startet apache2.

