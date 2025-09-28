
# Secrets 

**Doel:** In de secrets map staan alle bestanden en geheimen zoals usernames en notities over mijn infrastructuur die ik niet openbaar wil maken. Hier een voorbeeld wat ik van ChatGPT heb gekregen wat ik daar kan plaatsen en hoe.

## Structuur (lokaal)

```
secrets/
├─ azure.sp.json           # (optioneel) service principal voor CI/CD
├─ tailscale.authkey.txt   # (optioneel) auth key voor geautomatiseerde nodes
├─ pfSense-admin.txt       # admin wachtwoord pfsense (lokale notitie)
├─ esxi-root.txt           # root wachtwoord ESXi (lokale notitie)
└─ notes.md                # vrije notities (geen geheimen in README)
```

## Placeholders

- **Azure**
  - Subscription: Azure for Students (ID: <…>)
  - Tenant: Windesheim Office365 (ID: <…>)
  - Service Principal (optioneel voor CI):
    - `appId=<…>`
    - `password=<…>`
    - `tenant=<…>`
- **pfSense**
  - admin user (standaardnaam): `<admin>`
  - password: `<…>`
- **ESXi**
  - root password: `<…>`
- **GitHub**
  - PAT (optioneel): `<…>`

## Richtlijnen

- Nooit secrets in code of README.
- Verwijs in documentatie naar `secrets/` voor gevoelige info.
- Voor CI/CD: gebruik GitHub Secrets, niet plaintext.
