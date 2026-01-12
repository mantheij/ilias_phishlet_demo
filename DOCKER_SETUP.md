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
- **Hauptseite (index.html):**
  - `http://localhost/ilias.php?baseClass=ilrepositorygui&reloadpublic=1&cmd=&ref_id=1`
  - `http://localhost`
  
- **Login-Seite (login.html):**
  - `http://localhost/realms/hhn/protocol/openid-connect/auth?response_type=code&redirect_uri=https%3A%2F%2Filias.hs-heilbronn.de%2Fopenidconnect.php&client_id=hhn_common_ilias&nonce=f3c0d00e231a5e52151555b6083fce1d&state=c256e44a86f146b6aeea5b238d0c4fb9&scope=openid+openid`
  - `http://localhost/login.php`
  
- **Phishing-Warnung (demo.html):**
  - `http://localhost/security-warning.php`
  - `http://localhost/warning.php`
  
- **MFA-Info (threats.html):**
  - `http://localhost/mfa-info.php`
  - `http://localhost/security-info.php`

## Commands

### Container starten
```powershell
docker-compose up -d
```

### Container stoppen
```powershell
docker-compose down
```

### Logs anschauen
```powershell
docker-compose logs -f
```

### Container neu starten
```powershell
docker-compose restart
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
