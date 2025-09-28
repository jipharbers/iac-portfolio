# Infra‑overzicht (Jip) – Hybride Lab

## 1. Context

- **Doel**: hybride oefenomgeving (on‑prem + Azure) voor IAC‑opdrachten.
- **Bereikbaarheid**: Tailscale tailnet; pfSense routers adverteren LAN‑subnets.
- **Ontwikkelmachine**: Windows 11 + WSL Ubuntu (VS Code), SSH‑keys voor ESXi/Azure.

## 2. Netwerkoverzicht

**ASCII‑diagram (hoog over)**

```
             (Internet)
                 |
            [Tailscale]
              /     \
     [chipwall-j2]  [chipwall-j3]
        pfSense        pfSense
      10.10.20.1     10.10.30.1
        |                 |
   10.10.20.0/24    10.10.30.0/24
        |                 |
  [j2-esxi-01]        (TSC lab)
   10.10.20.20
        |
  [J2-ChipStation-W11]
   10.10.20.10 (WSL)
        |
      (Azure)
     vnet: J2-vnet-iac (10.10.25.0/24)
        |
     VM(s) chipuser
```

**Segmenten** (kort):

- **J2 LAN** – 10.10.20.0/24 (gateway 10.10.20.1)
- **J3 LAN** – 10.10.30.0/24 (gateway 10.10.30.1)
- **Azure (planned)** – `J2-vnet-iac` 10.10.25.0/24 (West Europe)

## 3. IP & DNS overzicht (kort)

| Site  | CIDR          | Gateway    | DHCP pool    | Statics (rol)                                             |
| ----- | ------------- | ---------- | ------------ | --------------------------------------------------------- |
| J2    | 10.10.20.0/24 | 10.10.20.1 | .100–.199    | .10–.19 desktops, .20–.29 mgmt/servers, .200–.254 overige |
| J3    | 10.10.30.0/24 | 10.10.30.1 | .100–.199    | idem                                                      |
| Azure | 10.10.25.0/24 | (n.v.t.)   | (Azure DHCP) | reservering: .100–.199 dynamic (conceptueel)              |

**Hosts (kern)**

| Hostname           | IPv4                        | Rol                     |
| ------------------ | --------------------------- | ----------------------- |
| chipwall-j2        | 10.10.20.1                  | pfSense gateway         |
| chipwall-j3        | 10.10.30.1                  | pfSense gateway         |
| J2-ChipStation-W11 | 10.10.20.10                 | Windows 11 + WSL dev    |
| j2-esxi-01         | 10.10.20.20                 | ESXi host               |
| (Azure vm1/vm2)    | public: via `AZURE_IPS.txt` | Ubuntu VM(s) `chipuser` |

> DNS/hosts: in WSL staat `j2-esxi-01` → 10.10.20.20 in `/etc/hosts`.

## 4. Accounts & gebruikers

| Platform        | User(s)                                                |
| --------------- | ------------------------------------------------------ |
| pfSense (J2/J3) | *admin* (plaatsvervanger), **geen wachtwoord in repo** |
| ESXi            | root (key‑login via *skylab* public key)               |
| Windows 11      | lokale admin/user (geen wachtwoord in repo)            |
| WSL Ubuntu      | `student`                                              |
| Azure VM(s)     | `chipuser` (SSH key)                                   |
| GitHub          | `jipharbers@gmail.com` (account)                       |
| Azure           | `s1161878@student.windesheim.nl` (account)             |
| Tailscale       | `s1161878.student.windesheim@gmail.com` (tailnet)      |

**Policy**

- Geen wachtwoorden in Git.
- Secrets lokaal in `secrets/` (niet committen). Verwijs naar `docs/secrets.example.md`.

## 5. SSH keys

| Keypair          | Pad             | Gebruikt voor                                   |
| ---------------- | --------------- | ----------------------------------------------- |
| skylab (ED25519) | `~/.ssh/skylab` | ESXi root key‑login (`authorized_keys` op ESXi) |
| azure (ED25519)  | `~/.ssh/azure`  | Azure VM `admin_ssh_key` (user `chipuser`)      |

Notities

- Er is **geen aparte ESXi key**; *skylab* wordt gebruikt voor ESXi.
- Keys zijn **privé**; public keys worden gedistribueerd via cloud‑init (Azure) of handmatig (ESXi).

## 6. Azure

**Subscription/tenant**

- Subscription: *Azure for Students*
- Regio: `westeurope`
- Resource Group: `J2`

**Naming** (voorstellen, kort)

- vnet: `J2-vnet-iac`
- subnet: `J2-snet-default`
- nsg: `J2-nsg-default`
- nic: `J2-nic-<vmname>`
- pip: `J2-pip-<vmname>`
- vm: `J2-vm-<index>` (bijv. `J2-vm1`, `J2-vm2`)

**Terraform outputs**

- `AZURE_IPS.txt` met public IP’s (automatisch via `local_file`)

**Planned (network)**

- vnet 10.10.25.0/24; conceptueel houden we .100–.199 als “dynamic zone”. Azure beheert DHCP in het hele subnet; vaste reserveringen niet via pfSense.
- Koppeling met Tailscale: later uitwerken (opties: Tailscale SSH, tailscale‑subnet router in cloud, of gateway‑VM). Keuze en impact komen in week 3–4.

## 7. On‑prem (ESXi/pfSense)

- ESXi host: `j2-esxi-01` (10.10.20.20), datastore aanwezig, SSH key‑login ingeschakeld.
- Plan week 2 ESXi: 3× Ubuntu VM met cloud‑init (ovftool). IP’s documenteren in `evidence/week2/` + IPv4‑lijst (tekstbestand) in `terraform/week2/esxi/`.
- pfSense J2/J3: DHCP ranges zoals tabel; Tailscale‑subnet routing actief.

## 8. Hosts & OS

| Host               | OS                      | Notities                               |
| ------------------ | ----------------------- | -------------------------------------- |
| ChipBookPro        | macOS 15.7              | RDP naar J2‑Windows 11                 |
| J2‑ChipStation‑W11 | Windows 11 + WSL Ubuntu | dev, VS Code, Terraform/Ansible        |
| ESXi VMs (week 2)  | Ubuntu                  | cloud‑init + SSH key                   |
| Azure VMs (week 2) | Ubuntu                  | cloud‑init + SSH key (user `chipuser`) |

## 9. Bewijs & inlevering (week 2)

- Screenshots: Terraform apply, Azure Portal, SSH/`hello.txt`, IP‑outputs.
- Video: SSH vanaf **ESXi‑VM** → **Azure‑VM** (hostname tonen).
- Code: `terraform/week2/azure/*` en later `terraform/week2/esxi/*`.

## 10. Veiligheid & repo‑hygiëne

- `.gitignore` bevat `secrets/`, `.terraform/`, `*.tfstate*`, `*.key`, `*.pem`, `.env`, `*.retry`.
- Geen plaintext wachtwoorden in README of code.
- Voorbeelden en placeholders staan in `docs/secrets.example.md`.

---

# FILE: docs/secrets.example.md

# Secrets – voorbeeld (niet committen)

**Doel:** uitleg en placeholders voor gevoelige gegevens. Maak lokaal een map `secrets/` (staat in `.gitignore`). Voeg hier je eigen varianten toe en **commit nooit** echte waarden.

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
