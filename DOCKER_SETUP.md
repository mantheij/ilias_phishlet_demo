# ILIAS Phishlet Demo - Docker Setup

Dieser Docker-Setup erstellt einen lokalen Apache-Webserver mit URL-Rewriting, sodass die Seite unter einer gefälschten ILIAS-URL zugänglich ist.

## Voraussetzungen

- Docker installiert ([https://www.docker.com/](https://www.docker.com/))
- Docker Compose installiert (in der Regel bereits enthalten)

## Installation & Start

### 1. Docker-Image bauen
Im Projektverzeichnis:
```powershell
docker build -t ilias-phishlet-demo .
```

### 2. Container starten
```powershell
docker-compose up -d
```

Die Seite ist jetzt erreichbar unter:

```http://<deine-IP>:80```

Um die IP herauszufinden: 

Windows:

```powershell
ipconfig
```


Mac: 
```zsh 
ipconfig getifaddr en0
```

## Wichtig für Sicherheitstests

**Rechtliche Hinweise:**
- Diese Demo darf AUSSCHLIESSLICH zu Schulungs- und Testzwecken verwendet werden
- Verwenden Sie diese NICHT für echte Phishing-Attacken
- Nutzen Sie diese nur in kontrollierten Umgebungen mit ausdrücklicher Genehmigung
- Alle Aktivitäten müssen dokumentiert und legal sein

## Anpassungen

Falls Sie die Hosts-Datei ändern möchten, bearbeiten Sie einfach die `docker-compose.yml`:

```yaml
environment:
  - VIRTUAL_HOST=ilias.hs-heilbronn.de
```

Oder passen Sie den Port an:
```yaml
ports:
  - "8080:80"  # Dann erreichbar unter http://localhost:8080
```
