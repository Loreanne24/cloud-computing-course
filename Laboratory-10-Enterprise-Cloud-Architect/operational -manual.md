
### 5.2 `operational-manual.md` (executive handover — this is graded heavily)

```markdown
# CCM101 — Cloud Computing
# Enterprise Cloud Architect — Operational Manual

**Project:** Secure Multi-Tier Web Application
**Application Stack:** WordPress + MySQL 8.0
**Prepared by:** [Your Name(s)]
**Section:** BSIT 2A
**Instructor:** Jenkielyn C. Torres
**Date:** [Month Year]

---

## 1. Executive Summary
This manual describes the deployment, security, and maintenance of a
production-ready WordPress + MySQL stack running on Ubuntu Server 24.04
inside a VirtualBox hypervisor. The environment enforces a default-deny
firewall, persistent Docker volumes, and a cron-scheduled disaster-recovery
backup system.

## 2. Architecture Overview
[Reference architecture-diagram.png]
- **Layer 1 – Host:** Laptop running VirtualBox
- **Layer 2 – Hypervisor:** Bridged network to LAN
- **Layer 3 – VM:** Ubuntu Server 24.04, UFW default-deny
- **Layer 4 – Containers:** `wp-app` (port 80) + `wp-mysql` (internal 3306)
- **Layer 5 – Storage:** Docker named volumes `wp_data`, `db_data`
- **Layer 6 – Automation:** Cron → `automation-script.sh` @ 02:00

## 3. Prerequisites
- VirtualBox 7.x
- Ubuntu Server 24.04 ISO
- 4 GB RAM, 2 vCPU, 25 GB disk
- GitHub account

## 4. Deployment Procedure
### 4.1 Provision VM
1. Create VM (Bridged adapter). Install Ubuntu Server, enable OpenSSH.
2. `sudo apt update && sudo apt upgrade -y`

### 4.2 Install Docker
[Paste the Docker install commands from Phase 2.1]

### 4.3 Deploy Stack
```bash
git clone <repo>
cd Laboratory-10-Enterprise-Cloud-Architect
cp .env.example .env && nano .env
docker compose up -d
docker compose ps