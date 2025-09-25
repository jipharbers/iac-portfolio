# Week 1 – Rapport
Datum: 25-09-2025

Deze week heb ik de basis op ESXi en mijn werkstation netjes afgerond en aantoonbaar gemaakt. Op ESXi heb ik een extra datastore van 50 GB toegevoegd en SSH-login ingeschakeld. Verder heb ik hostname-resolving geregeld zodat ik niet meer op IP hoef te werken: `j2-esxi-01` verwijst nu naar `10.10.20.20` via `/etc/hosts` in WSL. Dat leest en werkt prettiger, en het sluit beter aan op hoe Ansible-inventories straks gaan werken.

Voor key-based SSH heb ik een ED25519-sleutel aangemaakt (Skylab + ESXi). In eerste instantie lukte inloggen met die sleutel niet. Na wat gegoogle kwam ik erachter dat ESXi standaard in FIPS-modus draait en ED25519 daardoor niet accepteert. Ik heb FIPS voor SSH uitgezet en de service herstart, daarna werkte key-login wel. Vervolgens heb ik met Ansible een “hello”-test gedaan: `ansible.builtin.ping` naar `j2-esxi-01` met de hostname in de ad-hoc inventory. Die gaf netjes `SUCCESS` en `pong`, dus de basisvoorwaarde “Ansible kan verbinden” is binnen.

Aan Git-kant heb ik mijn repo aangemaakt, lokaal gecloned en gevuld met de eerste structuur en bewijsmateriaal. Ik heb de link van de repo ook ingeleverd op de ELO, zodat de weekopdracht voor week 1 formeel meetelt.

Wat er tegenzat en hoe ik het opgelost heb:
- Ik probeerde eerst `scp` uit te voeren vanaf de ESXi-shell, maar die public key stond natuurlijk op mijn WSL-machine. Uiteindelijk gewoon vanuit WSL de key naar `/tmp` op ESXi gekopieerd en toegevoegd aan `/etc/ssh/keys-root/authorized_keys`.
- Ansible klaagde een keer over `ssh_askpass` (geen TTY). Opgelost door de sleutel in de `ssh-agent` te laden en eventueel `IdentitiesOnly` te forceren, zodat er geen prompt nodig is.

Wat ik van deze week inlever:
- Repo-URL staat op de ELO.
- Screenshots in `evidence/week1/` (hostname toevoegen, key-login op ESXi, Ansible ping met hostname, en de 50 GB datastore).

Kortom: mijn setup doet het nu zoals hij moet, met hostname-based SSH en Ansible-connectiviteit. D
