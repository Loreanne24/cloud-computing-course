# Laboratory 10 — Mission 10: The Enterprise Cloud Architect

**Student:** Rodelas, Loreanne L., Dela Cruz, Ivan Daryll C., | **Section:** BSIT 4H
**Stack:** WordPress + MySQL 8.0 (Docker Compose)
**Host:** VirtualBox + Ubuntu Server 24.04 LTS

## Files
| File | Purpose |
|------|---------|
| `architecture-diagram.png` | Network topology & container layout |
| `docker-compose.yml` | Multi-tier IaC deployment |
| `automation-script.sh` | Daily DB backup + health check (cron 02:00) |
| `operational-manual.md` | Client handover documentation |
| `final-reflection.md` | Mission 1 → 10 journey |

## Quick Deploy
```bash
git clone <this-repo>
cd Laboratory-10-Enterprise-Cloud-Architect
cp .env.example .env && nano .env   # set passwords
docker compose up -d
