# Infrastruktureinrichtung für den Informatik-Unterricht
Guter Informatik-Unterricht zeichnet sich dadurch aus, dass Schülerinnen und Schüler die Möglichkeiten haben echte kleine Projekte zu realisieren und die Projekte online stellen können.
In diesem git-Repository findet ihr alles, was es für den Aufbau einer rudimentären Infrastruktur braucht.

## Voraussetzungen
* SSH-Zugriff auf einen Ubuntu Server 22.04 LTS mit mind. 2 Cores, 2GB Arbeitsspeicher, 20GB Festplatte
* Erreichbarkeit des Servers innerhalb und außerhalb der Schule (externes Hosting bei einem Hostinganbieter erleichtert den Zugriff) 
* Zugriff auf das Verwaltungskonto des Hosting-Anbieters

(Hinweis: SSH Zugriff auf externe Server ist innerhalb der Schule oft gesperrt. Eine Konsole kann man über das Verwaltungskonto des Hosting-Anbieters bekommen. So kann auch innerhalb der Schule der Server administriert werden.)

## Erstmaliges Einrichten des Servers
Zunächst sollen auf dem Server rudimentäre Programme installiert werden und alle aktuellen updates eingespielt werden. Gehe dazu wie folgt vor:
* Verbinde dich per SSH auf deinen Server
* Gib folgenden Befehl ein und bestätige mit der Enter-Taste:
  wget -O - https://raw.githubusercontent.com/istichel/Infrastruktur-Einrichtung/main/install.sh | bash
  => Der Vorgang kann ein Wenig dauern. Nach dem Vorgang wird der Server neu gestartet.
