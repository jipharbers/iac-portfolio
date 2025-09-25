# IAC Portfolio – Jip
Welkom op mijn Github repo!
Ik haal dit vak in in mijn reparatiesemester, ik hoop dat ik het een beetje goed doe.

## Doel
Hybride cloud lab met geautomatiseerde provisioning (Terraform), config management (Ansible) en containers (Docker).

## Hoe draai je dit?
- Vereist: Terraform, Ansible, Docker.
- Volg de per-onderdeel handleidingen: [evidence/week1/terraform.md](evidence/week1/terraform.md) (komt in week 1).
- Demo-video: (link komt bij eindoplevering).

## Structuur
- `evidence/` — bewijsmateriaal (screenshots, korte logs)
- `terraform/` — IaC voor Azure/ESXi (vanaf week 2)
- `ansible/` — inventories, roles, playbooks (vanaf week 3)
- `docker/` — Dockerfiles/Compose (vanaf week 4)

## Bewijs
- Week 0: ansible --version + ping naar ESXi (zie `evidence/week0/`).


## Week 1 – Hello IAC (ontwikkelomgeving + eerste bewijs)

Samenvatting
- ESXi geconfigureerd: SSH ingeschakeld en datastore van 50 GB toegevoegd.
- Hostname-resolving ingericht: j2-esxi-01 → 10.10.20.20 via /etc/hosts.
- SSH-sleutels aangemaakt (ED25519 voor Skylab en voor ESXi). ED25519 werkte niet direct op ESXi door FIPS; FIPS voor SSH uitgezet en key-based login geactiveerd.
- Ansible “hello” uitgevoerd: succesvolle `ansible.builtin.ping` naar ESXi met hostname.

Bewijs (screenshots in `evidence/week1/`)
- W1-adding-hostname-of-esxi-to-wsl-YYYYMMDD.png
- W1-adding-ssh-key-to-esxi-YYYYMMDD.png
- W1-ESXi-SSH-key-login-YYYYMMDD.png
- W1-ping-pong-esxi-ansible-(met-hostname-nu)-YYYYMMDD.png
- W1-ESXi-datastore-added-YYYYMMDD.png

Link ingeleverd in ELO
- Repository-URL: [Hier](https://github.com/jipharbers/iac-portfolio/)

Notities t.b.v. latere weken
- Keys en hostname werken; Ansible-connectiviteit is bewezen. Klaar voor Terraform + CloudInit (Week 2).
