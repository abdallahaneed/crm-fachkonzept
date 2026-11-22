#!/usr/bin/env bash
# Startet die Demo-API, schickt Beispielanfragen und stoppt den Server wieder.
# Aufruf: ./demo/demo.sh
set -euo pipefail
cd "$(dirname "$0")"

URL="http://127.0.0.1:8000"
PY="$(command -v python3.12 || command -v python3)"

if [ ! -d .venv ]; then
  "$PY" -m venv .venv
fi
.venv/bin/pip install -q --disable-pip-version-check -r requirements.txt

.venv/bin/uvicorn main:app --port 8000 --log-level warning &
SERVER=$!
trap 'kill $SERVER 2>/dev/null' EXIT

# Warten, bis der Server antwortet
for _ in $(seq 1 30); do
  curl -s "$URL/leads" >/dev/null && break
  sleep 0.5
done

anfrage() {
  curl -s -w "\nHTTP %{http_code}\n\n" -X POST "$URL/anfragen" \
    -H "Content-Type: application/json" -d "$1"
}

echo "1. Gültige Anfrage über das Website-Formular"
anfrage '{"firma": "Muster GmbH", "name": "Anna Schmidt", "email": "anna.schmidt@muster.de", "eventdatum": "2027-06-12", "gaeste": 80, "kanal": "formular", "einwilligung": true}'

echo "2. Dieselbe Person fragt noch einmal an (Dublette)"
anfrage '{"firma": "Muster GmbH", "name": "Anna Schmidt", "email": "Anna.Schmidt@muster.de", "eventdatum": "2027-07-03", "gaeste": 60, "kanal": "formular", "einwilligung": true}'

echo "3. Anfrage ohne Einwilligung"
anfrage '{"firma": "Beispiel AG", "name": "Jonas Weber", "email": "j.weber@beispiel.de", "eventdatum": "2027-05-20", "gaeste": 40, "kanal": "formular", "einwilligung": false}'

echo "4. Alle Leads"
curl -s -w "\nHTTP %{http_code}\n\n" "$URL/leads"

echo "5. Lead 1 auf gebucht setzen"
curl -s -w "\nHTTP %{http_code}\n\n" -X PATCH "$URL/leads/1" \
  -H "Content-Type: application/json" -d '{"status": "gebucht"}'

echo "Server wird gestoppt."
