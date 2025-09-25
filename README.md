# IAC Portfolio – Jip

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
- `.github/workflows` — optionele checks

## Weekoverzicht
- Week 0/1: omgeving & connectiviteit → bewijs in `evidence/week0` en `evidence/week1`.
- Week 2: Terraform & CloudInit.
- Week 3: Ansible (roles, idempotentie).
- Week 4: Docker (app/compose).
- Week 5: CI/CD (GitHub Actions).
- Week 6: Stabiliseren, demo, inpakken (zip + video).

