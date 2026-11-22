#!/usr/bin/env bash
# Rendert alle .mmd in diesem Ordner zu SVG und prüft, dass kein Label abgeschnitten ist.
# Voraussetzung: Node, Google Chrome, Mermaid CLI
#   PUPPETEER_SKIP_DOWNLOAD=1 npm install -g @mermaid-js/mermaid-cli
# Aufruf: ./diagrams/render.sh
set -euo pipefail
cd "$(dirname "$0")"

CHROME="${CHROME:-/Applications/Google Chrome.app/Contents/MacOS/Google Chrome}"
command -v mmdc >/dev/null || { echo "mmdc fehlt, siehe Kopf dieser Datei"; exit 1; }
[ -x "$CHROME" ] || { echo "Chrome nicht gefunden: $CHROME (Pfad per CHROME=... setzen)"; exit 1; }

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

cat > "$TMP/puppeteer.json" <<EOF
{"executablePath": "$CHROME", "headless": "new"}
EOF

# Neutrales Theme, HTML-Labels (brauchen Chrome für den PDF-Export), breiter Umbruch
cat > "$TMP/mermaid.json" <<'EOF'
{"theme": "neutral", "htmlLabels": true, "flowchart": {"htmlLabels": true, "wrappingWidth": 400}, "fontFamily": "Helvetica, Arial, sans-serif"}
EOF

for f in *.mmd; do
  mmdc -q -p "$TMP/puppeteer.json" -c "$TMP/mermaid.json" -b white -i "$f" -o "${f%.mmd}.svg"
  echo "gerendert: ${f%.mmd}.svg"
done

# Prüfung: jedes Label muss innerhalb der SVG liegen und darf nicht überlaufen
cat > "$TMP/check.cjs" <<'EOF'
const puppeteer = require(process.env.NM + '/puppeteer');
const fs = require('fs'), path = require('path');
(async () => {
  const b = await puppeteer.launch({executablePath: process.env.CHROME, headless: 'new'});
  const p = await b.newPage();
  let bad = 0;
  for (const f of process.argv.slice(2)) {
    await p.setContent('<body style="margin:0;background:#fff">' + fs.readFileSync(f, 'utf8') + '</body>');
    const r = await p.evaluate(() => {
      const svg = document.querySelector('svg'); svg.style.maxWidth = 'none';
      const vb = svg.viewBox.baseVal; svg.setAttribute('width', vb.width); svg.setAttribute('height', vb.height);
      const s = svg.getBoundingClientRect(); const out = [];
      document.querySelectorAll('foreignObject div, foreignObject span, text').forEach(e => {
        const t = e.getBoundingClientRect(); if (!e.textContent.trim() || t.width === 0) return;
        if (t.left < s.left - 1 || t.right > s.right + 1 || t.top < s.top - 1 || t.bottom > s.bottom + 1) out.push('außerhalb: ' + e.textContent.trim());
        if (e.tagName !== 'text' && e.scrollWidth > e.clientWidth + 1) out.push('Überlauf: ' + e.textContent.trim());
      });
      return {w: Math.ceil(s.width), h: Math.ceil(s.height), out: [...new Set(out)]};
    });
    await p.setViewport({width: r.w, height: r.h});
    await p.screenshot({path: path.join(process.env.SHOTS, path.basename(f, '.svg') + '.png')});
    console.log(path.basename(f), r.w + 'x' + r.h, r.out.length ? r.out.join(' | ') : 'OK');
    bad += r.out.length;
  }
  await b.close(); process.exit(bad ? 1 : 0);
})();
EOF

SHOTS="${SHOTS:-$TMP/shots}"; mkdir -p "$SHOTS"
NM="$(npm root -g)/@mermaid-js/mermaid-cli/node_modules" CHROME="$CHROME" SHOTS="$SHOTS" node "$TMP/check.cjs" *.svg
