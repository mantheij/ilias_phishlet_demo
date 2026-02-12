@echo off
echo ====================================
echo   ILIAS Phishlet Demo - Starter
echo ====================================
echo.

:: Container starten
docker-compose up -d

:: IP auslesen
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"IPv4"') do (
    set IP=%%a
)
set IP=%IP: =%

set URL=http://%IP%/login.html

echo.
echo ====================================
echo   Seite erreichbar unter:
echo.
echo   %URL%
echo ====================================
echo.

:: QR-Code generieren via Python (ist bei Docker meist vorhanden)
python -c "import subprocess; subprocess.run(['pip','install','--quiet','qrcode'], capture_output=True); import qrcode; qr=qrcode.QRCode(border=1); qr.add_data('%URL%'); qr.print_ascii(invert=True); img=qr.make_image(); img.save('qrcode.png'); print('\nQR-Code gespeichert als: qrcode.png')" 2>nul

if errorlevel 1 (
    echo QR-Code konnte nicht erstellt werden.
    echo Python installieren fuer QR-Code Support: https://www.python.org
)

echo.
echo Diesen Link/QR-Code an die Schueler verteilen.
echo.
echo Druecke eine beliebige Taste zum Beenden des Servers...
pause >nul

:: Container stoppen
docker-compose down
echo Server gestoppt.