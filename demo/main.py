from datetime import date, datetime
from typing import Dict

from fastapi import FastAPI, HTTPException, Response
from pydantic import BaseModel, EmailStr, PositiveInt

app = FastAPI(title="CRM-Demo: Anfrage wird Lead")

ERLAUBTE_STATUS = {"qualifiziert", "angebot", "gebucht", "abgesagt"}

# Nur im Arbeitsspeicher: nach einem Neustart ist alles weg.
leads: Dict[int, dict] = {}


class Anfrage(BaseModel):
    firma: str
    name: str
    email: EmailStr
    eventdatum: date
    gaeste: PositiveInt
    kanal: str
    einwilligung: bool


class StatusAenderung(BaseModel):
    status: str


@app.post("/anfragen", status_code=201)
def anfrage_anlegen(anfrage: Anfrage, response: Response):
    if not anfrage.einwilligung:
        raise HTTPException(400, "Einwilligung fehlt")

    # Dublettenprüfung: gleiche E-Mail heißt gleicher Lead
    for lead in leads.values():
        if lead["email"].lower() == anfrage.email.lower():
            response.status_code = 200
            return lead

    lead_id = len(leads) + 1
    leads[lead_id] = {
        "id": lead_id,
        **anfrage.model_dump(),
        "eingang": datetime.now().isoformat(timespec="seconds"),
        "status": "neu",
    }
    return leads[lead_id]


@app.get("/leads")
def leads_auflisten():
    return list(leads.values())


@app.patch("/leads/{lead_id}")
def status_aendern(lead_id: int, aenderung: StatusAenderung):
    if lead_id not in leads:
        raise HTTPException(404, "Lead nicht gefunden")
    if aenderung.status not in ERLAUBTE_STATUS:
        raise HTTPException(400, f"Status nicht erlaubt: {aenderung.status}")
    leads[lead_id]["status"] = aenderung.status
    return leads[lead_id]
