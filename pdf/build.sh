#!/usr/bin/env bash
# Baut crm-fachkonzept.pdf aus pdf/konzept.html mit Headless Chrome.
# Chrome ist nötig, weil die Diagramm-Labels HTML in den SVGs sind.
# Aufruf: ./pdf/build.sh
set -euo pipefail
cd "$(dirname "$0")"

CHROME="${CHROME:-/Applications/Google Chrome.app/Contents/MacOS/Google Chrome}"
[ -x "$CHROME" ] || { echo "Chrome nicht gefunden: $CHROME (Pfad per CHROME=... setzen)"; exit 1; }

SEITE="file://$PWD/konzept.html"
OPTS=(--headless=new --disable-gpu --allow-file-access-from-files --virtual-time-budget=10000)

# Passt der Inhalt auf zwei Seiten?
PASST="$("$CHROME" "${OPTS[@]}" --dump-dom "$SEITE" 2>/dev/null | grep -o 'data-passt="[^"]*"' || true)"
if [ "$PASST" != 'data-passt="ja"' ]; then
  echo "Inhalt passt nicht: ${PASST:-keine Prüfung möglich}"
  exit 1
fi

"$CHROME" "${OPTS[@]}" --no-pdf-header-footer --print-to-pdf="../crm-fachkonzept.pdf" "$SEITE" 2>/dev/null
echo "erstellt: crm-fachkonzept.pdf"
