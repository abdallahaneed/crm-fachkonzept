# CRM-Fachkonzept: Coffee-Bike-Caterer im Franchise-Netz

Fallstudie zur Übung. Standort Bonn, Teil eines Franchise-Netzes. Schwerpunkt: B2B-Events.

## Seite 1: Konzept

### Ausgangslage und Ziel

Anfragen kommen über vier Kanäle: Website-Formular, E-Mail, Telefon oder WhatsApp, Instagram.

Pro Monat gehen etwa 20 Anfragen ein (Annahme, Spanne 10 bis 30). Jede Anfrage wird am selben Tag beantwortet (Annahme). Etwa 30 Prozent der Kunden buchen erneut (Annahme, Spanne 20 bis 40).

Das Problem:

1. Es gibt keine zentrale Kundensicht über die vier Kanäle.
2. Nachfassen läuft manuell und hängt vom Gedächtnis ab.
3. Auf Netzwerkebene gibt es keine gemeinsamen Daten.

Schnellere Antworten sind kein Ziel. Die Antwort kommt schon heute am selben Tag. Die Ziele sind:

1. Jede Anfrage wird erfasst, egal über welchen Kanal.
2. Mehr Kunden buchen erneut.

### Datenmodell

1. Account: das Unternehmen, das bucht. Name, Branche, Adresse, Standort im Netz.
2. Kontakt: die Person beim Account. Name, Rolle, E-Mail, Telefon, Einwilligung. Ein Account hat einen oder mehrere Kontakte.
3. Lead: eine neue Anfrage vor der Prüfung. Kanal, Eingangsdatum, Eventdatum, Gästezahl, Ort. Wird nach der Prüfung zu einer Opportunity oder abgelehnt.
4. Opportunity: eine geprüfte Anfrage mit Angebot. Angebotswert, Status, Nachfassdatum, Absagegrund. Gehört zu einem Account.
5. Buchung: der bestätigte Auftrag. Eventdatum, Leistung, Preis, Standort, Feedback-Status. Entsteht aus einer gewonnenen Opportunity.
6. Ticket: ein Anliegen nach dem Event. Feedback, Beschwerde oder Rückfrage. Gehört zu einer Buchung und einem Kontakt.

### Prozess von der Anfrage zur Buchung

1. Eine Anfrage geht über einen der vier Kanäle ein.
2. Daraus entsteht ein Lead. Das Formular legt ihn automatisch an. E-Mails werden ins System weitergeleitet. Telefon, WhatsApp und Instagram erfasst das Team über eine kurze Eingabemaske.
3. Das System prüft auf Dubletten und ordnet den Lead einem bestehenden Kontakt und Account zu.
4. Das Team prüft Datum, Ort und Gästezahl. Passt alles, wird der Lead zur Opportunity.
5. Das Angebot geht am selben Tag raus.
6. Kommt nach drei Tagen keine Antwort, legt das System eine Nachfass-Aufgabe an.
7. Bei Zusage entsteht eine Buchung. Bei Absage wird der Grund erfasst.

### Customer Journey nach dem Event

1. Tag 1 nach dem Event: Feedback-Mail mit einer NPS-Frage (0 bis 10).
2. NPS 9 bis 10: Dank und Bitte um eine Bewertung oder Empfehlung.
3. NPS 7 bis 8: Dank und eine offene Frage, was gefehlt hat.
4. NPS 0 bis 6: Das System legt ein Ticket an. Der Inhaber ruft innerhalb von zwei Werktagen an.
5. Tag 90 nach dem Event: Angebot zur Wiederbuchung, zum Beispiel für das nächste Sommerfest oder die Weihnachtsfeier. Entfällt, wenn der Kunde schon erneut gebucht hat. Bei offenem Ticket erst nach dessen Abschluss.

### Zuordnung zu den BSI-Modulen

1. BSI CRM: Accounts, Kontakte, Leads, Opportunities und Buchungen.
2. BSI CX: Kommunikation über die Kanäle, Tickets und die Journey nach dem Event.
3. BSI CDP: Kundendaten aus allen Kanälen an einer Stelle. Grundlage für die Auswahl beim 90-Tage-Angebot.
4. BSI Insight: KPIs pro Standort und für das ganze Netz.
5. BSI AI: nicht in Phase 1. Später prüfen, zum Beispiel für das Vorsortieren von Anfragen.

### KPIs

Alle Werte sind Annahmen.

1. Anfragen zentral erfasst: heute etwa 60 Prozent, Ziel 100 Prozent.
2. Antwort am selben Tag: heute etwa 100 Prozent, Ziel halten.
3. Abschlussquote Lead zu Buchung: heute etwa 40 Prozent, Ziel 50 Prozent.
4. Wiederbuchungsquote: heute etwa 30 Prozent, Ziel 40 Prozent nach zwölf Monaten.
5. Rücklauf Feedback-Mail: heute 0 Prozent (kein Prozess), Ziel 40 Prozent.
6. NPS: heute nicht gemessen, Ziel 50.

## Seite 2: Anhang

### User Stories

1. Must: Als Inhaber will ich alle Anfragen aus den vier Kanälen in einer Liste sehen, damit keine verloren geht.
2. Must: Als Mitarbeiter will ich eine Anfrage per Telefon oder WhatsApp in unter einer Minute erfassen, damit ich es auch unterwegs mache.
3. Must: Als Inhaber will ich nach drei Tagen ohne Antwort eine Nachfass-Aufgabe bekommen, damit kein Angebot liegen bleibt.
4. Must: Als Inhaber will ich, dass Kunden nach 90 Tagen ein Angebot zur Wiederbuchung bekommen, damit mehr Kunden erneut buchen.
5. Should: Als Kunde will ich einen Tag nach dem Event eine kurze Feedback-Mail, damit ich meine Meinung schnell loswerde.
6. Should: Als Inhaber will ich bei einem NPS von 0 bis 6 sofort ein Ticket, damit ich den Kunden anrufe, bevor er abspringt.
7. Could: Als Franchise-Zentrale will ich die KPIs aller Standorte vergleichen, damit gute Abläufe im Netz ankommen.
8. Won't (vorerst): Als Kunde will ich online selbst einen Termin buchen. Das bleibt außerhalb dieser Phase.

### Systemauswahl

Für einen einzelnen Betrieb reicht ein leichtes CRM. Für das Franchise-Netz passt BSI aus vier Gründen:

1. eine zentrale Plattform für alle Standorte,
2. eine eigene Sicht pro Standort,
3. Daten in der EU,
4. Konfiguration per Low-Code.

### Integration

Das Website-Formular schickt jede Anfrage per REST an das CRM. Dort entsteht direkt ein Lead. Das Anfrage-Postfach leitet E-Mails ins CRM weiter. Telefon, WhatsApp und Instagram laufen in Phase 1 über die Eingabemaske. Eine direkte Anbindung von WhatsApp und Instagram wird später geprüft. Bestätigte Buchungen gehen in den Teamkalender. Für die Rechnung werden die Buchungsdaten an das Rechnungsprogramm übergeben. Jeder Standort sieht nur seine eigenen Daten. Die Zentrale sieht die KPIs aller Standorte.

### Rollout

1. Phase 1, Monat 1 bis 2: Pilot in Bonn. CRM-Kern, Formular per REST, Eingabemaske, Nachfass-Aufgaben.
2. Phase 2, Monat 3 bis 4: Journey nach dem Event mit Feedback-Mail, NPS, Tickets und 90-Tage-Angebot. Erste KPI-Berichte.
3. Phase 3, ab Monat 5: weitere Standorte, Sicht für die Zentrale, Kundensegmente aus den gemeinsamen Daten.

### Risiken

1. Das Team erfasst Anfragen per Telefon und WhatsApp nicht. Gegenmaßnahme: eine Eingabemaske mit nur fünf Pflichtfeldern.
2. Feedback- und Angebotsmails verstoßen gegen den Datenschutz. Gegenmaßnahme: Einwilligung im Formular und Abmeldelink in jeder Mail, vorher rechtlich prüfen lassen.
3. Die Standorte pflegen Daten unterschiedlich. Gegenmaßnahme: einheitliche Pflichtfelder und Vorlagen, von der Zentrale vorgegeben.

Übungskonzept. Kein produktives BSI-System. Zahlen sind Annahmen.
