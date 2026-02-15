# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is an **ILIAS Phishlet Demo** — an educational phishing awareness tool that replicates the look and feel of the ILIAS LMS (Learning Management System) used at Hochschule Heilbronn (HHN). It is designed exclusively for classroom security training, where a teacher hosts the demo locally and students access it over the local network.

**Important:** This project is for authorized educational/security training use only. All content is in German.

## Running the Project

```bash
# Start (Docker must be running):
./start.sh          # macOS/Linux
start.bat           # Windows

# Manual Docker commands:
docker-compose up -d        # Start container
docker-compose down         # Stop container
docker build -t ilias-phishlet-demo .   # Rebuild image
```

The app runs on port 80 via Apache (PHP 8.1) in Docker. The start scripts auto-detect the host's LAN IP and generate a QR code for students to scan.

## Architecture

This is a **static HTML site** served by Apache with URL rewriting — there is no build system, no bundler, no package manager.

### Page Structure

- `login.html` — Fake Keycloak/HHN SSO login page (the phishing target page)
- `index.html` — Replica of the ILIAS main dashboard
- `demo.html` — Warning/reveal page shown after "phishing" attempt
- `risks.html`, `threats.html`, `steps.html`, `protection.html`, `examples.html` — Educational content pages about phishing

### Navigation & Layout

- `base.html` — Reference template showing the sidebar + dark-mode layout structure
- All educational pages share: hamburger menu, sidebar nav (`css/sidebar.css`), dark-mode styling
- `js/interactive.js` — Sidebar toggle logic and active-page highlighting (jQuery)
- `login.html` uses a completely different layout (Keycloak/PatternFly styling) from the rest of the site

### URL Rewriting (.htaccess)

Apache rewrites fake ILIAS-style URLs to the actual HTML files:
- `/ilias.php` → `index.html`
- `/realms/hhn/protocol/openid-connect/auth` → `login.html`
- `/warning.php`, `/security-warning.php` → `demo.html`
- `/mfa-info.php`, `/security-info.php` → `threats.html`

### CSS

- `css/delos.css`, `css/delos_cont.css`, `css/style.min.css` — ILIAS "Delos" theme styles (copied from real ILIAS)
- `css/patternfly*.css`, `css/pficon.css` — Keycloak login page styling
- `css/styles.css`, `css/demo_styles.css`, `css/sidebar.css` — Custom project styles

### Key Conventions

- Pages use `<base href="/">` dynamically (only when served via HTTP, not `file://`) to support both local file opening and Docker serving
- jQuery is used for DOM manipulation (`js/jquery.js`)
- Most JS/CSS files in `js/` and `css/` are vendor files copied from the real ILIAS/Keycloak instances — do not modify these
