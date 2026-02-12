#!/bin/bash

echo "===================================="
echo "  ILIAS Phishlet Demo - Starter"
echo "===================================="
echo ""

# Container starten
docker-compose up -d

# IP auslesen je nach OS
if [[ "$(uname)" == "Darwin" ]]; then
    # macOS
    IP=$(ipconfig getifaddr en0 2>/dev/null || ipconfig getifaddr en1 2>/dev/null)
else
    # Linux
    IP=$(hostname -I | awk '{print $1}')
fi

if [ -z "$IP" ]; then
    echo "FEHLER: Keine Netzwerkverbindung gefunden!"
    exit 1
fi

URL="http://${IP}/index.html"

echo ""
echo "===================================="
echo "  Seite erreichbar unter:"
echo ""
echo "  ${URL}"
echo "===================================="
echo ""

# QR-Code generieren
if command -v qrencode &>/dev/null; then
    qrencode -t UTF8 "$URL"
    qrencode -o qrcode.png "$URL"
    echo ""
    echo "QR-Code auch gespeichert als: qrcode.png"
else
    echo "QR-Code Generator nicht gefunden. Installieren mit:"
    if [[ "$(uname)" == "Darwin" ]]; then
        echo "  brew install qrencode"
    else
        echo "  sudo apt install qrencode"
    fi
fi

echo ""
echo "Diesen Link/QR-Code an die Schueler verteilen."
echo ""
echo "Druecke Ctrl+C zum Beenden des Servers..."

# Warten bis Ctrl+C
trap "echo ''; echo 'Server wird gestoppt...'; docker-compose down; echo 'Server gestoppt.'; exit 0" INT
while true; do sleep 1; done