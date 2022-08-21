# Infrastruktureinrichtung für den Informatik-Unterricht
Guter Informatik-Unterricht zeichnet sich dadurch aus, dass Schülerinnen und Schüler die Möglichkeiten haben echte kleine Projekte zu realisieren und die Projekte online stellen können.
In diesem git-Repository findet ihr alles, was es für den Aufbau einer rudimentären Infrastruktur braucht.

## Voraussetzungen
* SSH-Zugriff auf einen Ubuntu Server 22.04 LTS mit mind. 2 Cores, 2GB Arbeitsspeicher, 20GB Festplatte
* Erreichbarkeit des Servers innerhalb und außerhalb der Schule (externes Hosting bei einem Hostinganbieter erleichtert den Zugriff) 
* Zugriff auf das Verwaltungsbereich des Hosting-Anbieters

(Hinweis: SSH Zugriff auf externe Server ist innerhalb der Schule oft gesperrt. Eine Konsole kann man über das Verwaltungsbereich des Hosting-Anbieters bekommen. So kann auch innerhalb der Schule der Server administriert werden.)

## Erstmaliges Einrichten des Servers
Zunächst sollen auf dem Server rudimentäre Programme installiert werden und alle aktuellen updates eingespielt werden. Gehe dazu wie folgt vor:
* Verbinde dich per SSH auf deinen Server (Beim Eingeben des Kennworts bewegt sich der Text-Kursor nicht. Das ist normal!)
* Gib folgenden Befehl ein und bestätige mit der Enter-Taste:\
  wget -O - https://raw.githubusercontent.com/istichel/Infrastruktur-Einrichtung/main/install.sh | bash\
  => Der Vorgang kann ein Wenig dauern. Nach dem Vorgang wird der Server neu gestartet und man kann sich nach wenigen Minuten wieder per SSH verbinden.
 * Nach der Installation sind im Verzeichnis Infrastruktur-Einrichtung weitere Dateien, die bei der weiteren Einrichtung helfen können.

## Einrichtung einer webApp
Um eine webApp einzurichten, sind folgende Schritte zu absolvieren:
* Subdomain anlegen (im Verwaltungsbereich des Hosting Anbieters)
* Mit folgendem Befehl ein SSL Zertifikat bei letsEncrypt beschaffen: \
  wget -O - https://raw.githubusercontent.com/istichel/Infrastruktur-Einrichtung/main/subdomain.sh | bash \
  Die Anweisungen befolgen, d.h. Subdomain eingeben, Email-Adresse eingeben (Dummy-Adresse geht auch),Y,N


## Cheat Sheet - Befehle im Terminal
Befehl                  | Erklärung 
----------------------- | ----------------------- 
ls                      | Zeigt alle Dateien im aktuellen Verzeichnis an.
pwd                     | Zeigt das aktuelle Verzeichnis an.
cd verzeichnisName      | Wechselt in das angegebene Verzeichnis.
exit                    | Trennt die Verbindung zum Server.
