# CRM-Fachkonzept: Coffee-Bike-Caterer im Franchise-Netz

Fallstudie zur Übung. Standort Bonn, Teil eines Franchise-Netzes, vor allem B2B-Events.

## Seite 1: Konzept

### Ausgangslage und Ziel

Anfragen kommen über Website-Formular, E-Mail, Telefon oder WhatsApp und Instagram. Pro Monat sind es etwa 20 (Annahme, Spanne 10 bis 30). Etwa 30 Prozent der Kunden buchen erneut (Annahme, Spanne 20 bis 40).

Jede Anfrage wird am selben Tag beantwortet. Sie wird aber nirgends zentral erfasst. Nachfassen und Wiederbuchung hängen deshalb vom Gedächtnis ab. Das ist das eigentliche Problem. Auf Netzwerkebene fehlen zudem gemeinsame Daten.

Ziele:

1. Jede Anfrage wird erfasst, egal über welchen Kanal.
2. Mehr Kunden buchen erneut.

### Datenmodell

1. Account: das buchende Unternehmen.
2. Kontakt: die Person beim Account, mit Einwilligung.
3. Lead: die neue Anfrage mit Kanal, Eventdatum und Gästezahl.
4. Opportunity: die geprüfte Anfrage mit Angebot und Status.
5. Buchung: der bestätigte Auftrag mit Datum, Leistung und Standort.
6. Ticket: Feedback oder Beschwerde nach dem Event.

Ein Account hat mehrere Kontakte. Aus einem Lead wird eine Opportunity, aus einer gewonnenen Opportunity eine Buchung. Tickets hängen an der Buchung.

### Prozess

1. Die Anfrage wird zum Lead. Das Formular legt ihn automatisch an, die übrigen Kanäle erfasst das Team über eine kurze Eingabemaske.
2. Das System prüft auf Dubletten und ordnet Kontakt und Account zu.
3. Passen Datum, Ort und Gästezahl, wird der Lead zur Opportunity. Das Angebot geht am selben Tag raus.
4. Nach drei Tagen ohne Antwort entsteht eine Nachfass-Aufgabe.
5. Bei Zusage entsteht eine Buchung, bei Absage wird der Grund erfasst.

### Customer Journey nach dem Event

1. Tag 1: Feedback-Mail mit NPS-Frage (0 bis 10).
2. NPS 9 bis 10: Bitte um Empfehlung. NPS 7 bis 8: Frage, was gefehlt hat.
3. NPS 0 bis 6: Ticket und Rückruf innerhalb von zwei Werktagen.
4. Tag 90: Angebot zur Wiederbuchung, außer der Kunde hat schon erneut gebucht oder ein Ticket ist offen.

### BSI-Module

1. BSI CRM: Accounts, Kontakte, Leads, Opportunities, Buchungen.
2. BSI CX: Kanäle, Tickets und Journey nach dem Event.
3. BSI CDP: Kundendaten aus allen Kanälen, Auswahl für das 90-Tage-Angebot.
4. BSI Insight: KPIs pro Standort und für das Netz.
5. BSI AI: nicht in Phase 1, später etwa zum Vorsortieren von Anfragen.

### KPIs (Annahme)

| KPI | Heute | Ziel |
| :- | :- | :- |
| Anfragen zentral erfasst | ca. 60 % | 100 % |
| Antwort am selben Tag | ca. 100 % | halten |
| Abschlussquote Lead zu Buchung | ca. 40 % | 50 % |
| Wiederbuchungsquote | ca. 30 % | 40 % nach 12 Monaten |
| Rücklauf Feedback-Mail | 0 % | 25 % |
| NPS | nicht gemessen | 50 |

## Seite 2: Anhang

### User Stories

1. Must: Als Inhaber will ich alle Anfragen in einer Liste sehen.
2. Must: Als Mitarbeiter will ich eine Telefon- oder WhatsApp-Anfrage in unter einer Minute erfassen.
3. Must: Als Inhaber will ich nach drei Tagen ohne Antwort eine Nachfass-Aufgabe.
4. Must: Als Inhaber will ich, dass Kunden nach 90 Tagen ein Wiederbuchungsangebot bekommen.
5. Should: Als Kunde will ich einen Tag nach dem Event eine kurze Feedback-Mail.
6. Should: Als Inhaber will ich bei NPS 0 bis 6 sofort ein Ticket.
7. Could: Als Franchise-Zentrale will ich die KPIs aller Standorte vergleichen.
8. Won't (vorerst): Als Kunde will ich online selbst buchen.

### Systemauswahl

1. HubSpot: leichtes CRM, schnell eingerichtet. Reicht für einen Einzelbetrieb.
2. Salesforce und Microsoft Dynamics 365: große Plattformen, Optionen für das Netz.
3. BSI: europäischer Anbieter mit starker Datensouveränität, stark in regulierten Branchen, Konfiguration per Low-Code, eine Plattform mit eigener Sicht pro Standort.

BSI gewinnt hier. Es ist aber Enterprise-Software, deren Lizenzkosten sich erst über viele Standorte lohnen.

Für einen Einzelbetrieb wäre BSI zu groß. Für ein Franchise-Netz mit vielen Standorten passt es.

### Integration

Das Formular schickt jede Anfrage per REST ans CRM, dort entsteht ein Lead. Das Postfach leitet E-Mails weiter. Telefon, WhatsApp und Instagram laufen in Phase 1 über die Eingabemaske. Buchungen gehen in den Teamkalender und an das Rechnungsprogramm. Jeder Standort sieht nur seine Daten, die Zentrale die KPIs aller Standorte.

### Rollout

1. Phase 1, Monat 1 bis 2: Pilot in Bonn mit CRM-Kern, Formular per REST, Eingabemaske und Nachfass-Aufgaben.
2. Phase 2, Monat 3 bis 4: Journey nach dem Event und erste KPI-Berichte.
3. Phase 3, ab Monat 5: weitere Standorte und Sicht für die Zentrale.

### Risiken

1. Das Team erfasst Telefon und WhatsApp nicht. Gegenmaßnahme: Eingabemaske mit fünf Pflichtfeldern.
2. Feedback- und Angebotsmails verletzen den Datenschutz. Gegenmaßnahme: Einwilligung im Formular, Abmeldelink in jeder Mail, rechtliche Prüfung.
3. Standorte pflegen Daten unterschiedlich. Gegenmaßnahme: einheitliche Pflichtfelder und Vorlagen der Zentrale.

Übungskonzept. Kein produktives BSI-System. Zahlen sind Annahmen.
