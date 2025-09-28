# IAC Portfolio – Jip
Welkom op mijn Github repo!
Ik haal dit vak in in mijn reparatiesemester, ik hoop dat ik het een beetje goed doe.

## Doel
Hybride lab met geautomatiseerde provisioning (Terraform), config management (Ansible) en containers (Docker).

## Snel starten
- Vereist lokaal: Terraform, Ansible, Docker.
- ESXi host: `j2-esxi-01` (10.10.20.20). SSH met key-login.
- Zie per onderdeel: `terraform/`, `ansible/`, `docker/`.

## Demo-video (eind)
- Bestandsnaam: `Demo-IAC-<studentnummer>` (komt bij eindoplevering).
- Link: (vul later)

## Structuur
- `evidence/` — bewijzen per week (screenshots, korte outputs)
- `labs/` — korte weeklogs (wat ingeleverd/gedaan)
- `terraform/` — IaC (Azure + ESXi)
- `ansible/` — inventories, roles, playbooks
- `docker/` — container setup
- `scripts/` — hulpscripts (geen secrets)

## Weekoverzicht
- Week 0/1: omgeving & connectiviteit → bewijs in `evidence/week0` en `evidence/week1`.
- Week 2: Terraform & CloudInit.
- Week 3: Ansible (roles, idempotentie).
- Week 4: Docker (app/compose).
- Week 5: CI/CD (GitHub Actions).
- Week 6: Stabiliseren, demo, inpakken (zip + video).

# IAC Portfolio – Jip Harbers (S1161878)

Dit repo bevat mijn uitwerkingen voor **Infrastructure as Code** (semester Cloud Architecture & Automation). Elke week lever ik code + bewijs (screenshots/video) op; weekopdrachten moeten op tijd ingeleverd zijn, en voor de eindbeoordeling lever ik **alle code** + **één demo-video** in. Zie de studiewijzer. :contentReference[oaicite:3]{index=3}

- **Repo**: https://github.com/jipharbers/iac-portfolio
- **Azure subscription**: Azure for Students (tenant: Windesheim Office365) – regio: `westeurope`
- **Resource Group**: `J2`
- **On-prem**: pfSense (J2/J3), ESXi (Skylab), W11+WSL (dev)
- **Cloud**: Azure VMs via Terraform + cloud-init
- **Evidence**: `evidence/weekX/` (screenshots, korte video’s)
- **Uitgebreid infra-overzicht**: zie `docs/infra-overzicht.md`

## Snelle navigatie
- `terraform/` – declaratieve infra (Azure + ESXi)
- `ansible/` – config management (vanaf week 3)
- `evidence/weekX/` – bewijs per week (png/mp4/txt)
- `labs/weekX/` – korte weekrapporten
- `docs/` – uitgebreide documentatie (infra, secrets-example, DoD)

## Kerngegevens (kort)
> Lange zinnen niet in tabellen; alleen kernwaarden.

**Netwerk (J2/J3)**
| Site | CIDR | Gateway | DHCP-range | Rollen |
|---|---|---|---|---|
| J2 | 10.10.20.0/24 | 10.10.20.1 | 10.10.20.100–199 | .10–.19 desktops · .20–.29 mgmt/servers · .200–.254 statics |
| J3 | 10.10.30.0/24 | 10.10.30.1 | 10.10.30.100–199 | idem |

**Hosts (statics)**
| Hostname | IPv4 | Rol |
|---|---|---|
| chipwall-j2 | 10.10.20.1 | pfSense gateway |
| j2-esxi-01 | 10.10.20.20 | ESXi host |
| ChipStation-W11 | 10.10.20.10 | Windows 11 + WSL |

_Bron: eigen infra-overzicht_ (J2/J3 ranges en naming). :contentReference[oaicite:4]{index=4}

**Accounts (zonder wachtwoorden)**
| Platform | User |
|---|---|
| Azure VMs | `chipuser` |
| Linux (Skylab-VMs) | `student` of `Student` (Skylab default) |
| WSL | `student` |
| GitHub | `jipharbers@gmail.com` |
| Tailscale | `s1161878.student.windesheim@gmail.com` |

**SSH keys**
| Keypair | Locatie (priv) | Gebruik |
|---|---|---|
| skylab | `~/.ssh/skylab` | ESXi + on-prem |
| azure | `~/.ssh/azure` | Azure VMs (admin_ssh_key) |

> Geen aparte ESXi-key; **Skylab key** wordt voor ESXi gebruikt. Public keys zijn op doelhosts geplaatst; geen private keys in repo.

## Weekstatus (kort)
- **Week 1**: ESXi datastore + SSH key-login; Ansible ping op `j2-esxi-01`; repo opgezet. Evidence in `evidence/week1/`. (Zie `labs/week1/REPORT.md`.)
- **Week 2**: Terraform + cloud-init (Azure & ESXi), hybride SSH-demo (ESXi-VM → Azure-VM), IP-outputs. Zie DoD-checklist in `docs/dod-week2.md`. :contentReference[oaicite:5]{index=5}

## Veiligheid & repo-hygiëne
- **No passwords** in Git. Gebruik `docs/secrets.example.md` + lokale `secrets/` (ge-ignore-d).  
- `.gitignore` bevat:  
  ```  secrets/
    .tfvars
    .terraform/
    terraform.tfstate```
- SSH-keys blijven **buiten** de repo.

## Bronnen
- Studiewijzer: eisen portfolio (wekelijkse labs, code-zip + demo-video). :contentReference[oaicite:6]{index=6}
- IAC-gids (weekplanning & bewijs per week). :contentReference[oaicite:7]{index=7}
- VS Code + WSL workflow (aanbevolen). :contentReference[oaicite:8]{index=8}
- Cloud-init voorbeelden (`write_files`, `runcmd`). :contentReference[oaicite:9]{index=9}
- Terraform Azure Linux VM (`custom_data` Base64, `admin_ssh_key`). :contentReference[oaicite:10]{index=10}
- Tailscale subnet routers (advertise routes). :contentReference[oaicite:11]{index=11}
- VMware OVF Tool (voor ESXi deploys). :contentReference[oaicite:12]{index=12}

## Doel & scope

Dit portfolio documenteert mijn hybride lab (on‑prem ESXi + pfSense + Tailscale, plus Azure) en alle IAC‑code (Terraform, Cloud‑Init, Ansible, Docker). Het sluit aan op de studiewijzer *Infrastructure as Code – Compleet* en mijn eigen IAC‑gids. Deliverables per week, bewijs (screenshots/video) en code staan gestructureerd in deze repo.

## Inhoudsopgave

- [IAC Portfolio – Jip](#iac-portfolio--jip)
  - [Doel](#doel)
  - [Snel starten](#snel-starten)
  - [Demo-video (eind)](#demo-video-eind)
  - [Structuur](#structuur)
  - [Weekoverzicht](#weekoverzicht)
- [IAC Portfolio – Jip Harbers (S1161878)](#iac-portfolio--jip-harbers-s1161878)
  - [Snelle navigatie](#snelle-navigatie)
  - [Kerngegevens (kort)](#kerngegevens-kort)
  - [Weekstatus (kort)](#weekstatus-kort)
  - [Veiligheid \& repo-hygiëne](#veiligheid--repo-hygiëne)
  - [Tools \& versies](#tools--versies)
  - [Weekstatus](#weekstatus)
  - [Links](#links)

---

## Infra‑overzicht (kort)

Hybride omgeving met on‑prem (pfSense + ESXi) en Azure. Routing en remote access via Tailscale. Uitgebreide details en IP‑tabellen staan in `docs/infra-overzicht.md`.

**Kerncomponenten**

- **pfSense J2 (chipwall-j2)** – 10.10.20.1, DHCP‑pool 10.10.20.100–199
- **pfSense J3 (chipwall-j3)** – 10.10.30.1, DHCP‑pool 10.10.30.100–199
- **ESXi host** – j2-esxi-01 (10.10.20.20), datastore + SSH key‑login
- **Dev machine** – J2‑ChipStation‑W11 (10.10.20.10) met WSL Ubuntu
- **Azure** – Resource Group `J2`, regio `westeurope`, VM‑user `chipuser`
- **Tailscale** – tailnet met subnet routes voor 10.10.20.0/24 en 10.10.30.0/24

**Planned (Azure net)**

- **vnet:** `J2-vnet-iac` (10.10.25.0/24)
- **subnet default:** 10.10.25.0/24 (Azure beheert DHCP; conceptueel reserveren .100–.199 voor “dynamic”)
- **Doel:** later koppelen aan Tailscale (documentatie/keuzes uitgewerkt in `docs/infra-overzicht.md`)

---

## Snel starten (Azure – week 2)

**Doel:** 1–2 Ubuntu VM’s in Azure met `cloud-init` (legt `hello.txt` bij user `chipuser`). IP’s worden als Terraform output + lokaal bestand geëxporteerd.

**Voorwaarden**

- Azure CLI ingelogd: `az login` en juiste subscription: `az account set --subscription "Azure for Students"`
- Public key aanwezig: `/home/student/.ssh/azure.pub`

**Run**

1. Open deze repo in VS Code (WSL): `code .`
2. Ga naar `terraform/week2/azure/`.
3. Vul in `variables.tf` zo nodig `resource_group_name = "J2"`, `ssh_public_key_path` naar je public key.
4. Terminal (WSL):
   - `terraform init`
   - `terraform validate`
   - `terraform plan`
   - `terraform apply -auto-approve`
5. IP’s staan in output én in `AZURE_IPS.txt`. Test: `ssh -i ~/.ssh/azure chipuser@<PUBLIC_IP>` → `hostname && cat /home/chipuser/hello.txt`.

**Screenshot‑momenten** (opslaan in `evidence/week2/`)

- Einde van `apply` (resources *added*)
- `cat AZURE_IPS.txt`
- SSH + inhoud `hello.txt`
- Azure Portal overzicht van VM’s

---

## Repo‑structuur

```
iac-portfolio/
├─ README.md
├─ docs/
│  ├─ infra-overzicht.md
│  └─ secrets.example.md
├─ evidence/
│  ├─ week1/
│  └─ week2/
├─ labs/
│  ├─ week1/REPORT.md
│  └─ week2/REPORT.md (tbd)
├─ terraform/
│  └─ week2/
│     ├─ azure/
│     │  ├─ main.tf
│     │  ├─ variables.tf
│     │  ├─ outputs.tf (optioneel; outputs mogen ook in main.tf)
│     │  └─ cloud-init/cloud-config.yaml
│     └─ esxi/
│        ├─ (ovftool aanpak; tbd)
│        └─ cloud-init/ (tbd)
├─ ansible/ (vanaf week 3)
├─ docker/  (vanaf week 6)
└─ .github/workflows/ (CI: optioneel)
```

---

## Bewijs & inlevering

- **Bewijs per week** in `evidence/weekX/` (screenshots, korte outputs, korte video’s)
- **Week 2** – video: SSH vanaf **ESXi‑VM** → **Azure‑VM** (hostname tonen)
- **Portfolio eind** – code in GitHub **én** .zip + één demovideo `Demo-IAC-<studentnummer>`

> Zie de IAC‑studiewijzer: elke week op tijd inleveren is knock‑out. Week 2 code + video horen bij de eindbeoordeling.

---

## Veiligheid & repo‑hygiëne

- **Geen wachtwoorden/secrets in Git.**
- Gebruik lokale map `secrets/` (niet gecommit) en het sjabloon `docs/secrets.example.md`.
- `.gitignore` aanvullen met:

```
secrets/
*.pem
*.key
.env
.terraform/
*.tfstate*
*.retry
```

---

## Tools & versies

Kern tooling (WSL): Terraform, Azure CLI, Ansible, OVF Tool, VS Code.

Korte tabel (vul zelf aan met versies zodra geïnstalleerd):

| Tool      | Versie |
| --------- | ------ |
| Terraform | …      |
| Azure CLI | …      |
| Ansible   | …      |
| OVF Tool  | …      |
| VS Code   | …      |

**Versies opvragen** (in VS Code terminal):

- `terraform -v`
- `az version`
- `ansible --version`
- `ovftool --version` (na installatie)

---

## Weekstatus

- **Week 1**: ✔ SSH key‑login ESXi, hostname‑resolving, Ansible ping, repo‑URL ingeleverd.
- **Week 2 (Azure)**: in uitvoering – Terraform + cloud‑init voor 1–2 VM’s, IP‑outputs, SSH‑test.
- **Week 2 (ESXi)**: gepland – OVF Tool pad met 3 VM’s + cloud‑init, IP‑overzicht; video hybride SSH.

---

## Links

- Repo: [https://github.com/jipharbers/iac-portfolio](https://github.com/jipharbers/iac-portfolio)
- Azure subscription: *Azure for Students* (tenant: Windesheim Office365)

---