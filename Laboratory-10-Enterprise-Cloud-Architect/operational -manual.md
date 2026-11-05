import pypandoc, os, textwrap

md = r'''<div align="center">

# CCM101 — CLOUD COMPUTING

## ENTERPRISE CLOUD ARCHITECT
### OPERATIONAL MANUAL

**SECURE MULTI-TIER WEB APPLICATION**

<br>

| Project Information | Details |
|:---|:---|
| **Project** | Secure Multi-Tier Web Application |
| **Application Stack** | WordPress + MySQL 8.0 |
| **Prepared By** | Rodelas, Loreanne L. |
| | Dela Cruz, Ivan Daryll C. |
| | Ferrer Jr., Juan Renne V. |
| | Leal, Lorie Jane |
| | Belmoro, Edwin P. |
| **Section** | BSIT 4H |
| **Instructor** | Jenkielyn C. Torres |
| **Date** | September 2026 |

<br>

**TECHNICAL DOCUMENTATION · DEPLOYMENT · SECURITY · MAINTENANCE**

</div>

---

# TABLE OF CONTENTS

1. [Executive Summary](#1-executive-summary)
2. [Architecture Overview](#2-architecture-overview)
   - 2.1 Infrastructure Architecture
   - 2.2 Architecture Components
   - 2.3 Application Stack
3. [Prerequisites](#3-prerequisites)
   - 3.1 Hardware Requirements
   - 3.2 Software Requirements
   - 3.3 Required Accounts
4. [Deployment Procedure](#4-deployment-procedure)
   - 4.1 Provision Virtual Machine
   - 4.2 Install Docker
   - 4.3 Deploy Application Stack
   - 4.4 Verify Container Status
   - 4.5 Verify Data Persistence
5. [Security Controls](#5-security-controls)
   - 5.1 Configure UFW Firewall
   - 5.2 SSH and Account Security
   - 5.3 Database and Secret Security
   - 5.4 WordPress and Docker Security
6. [Backup & Recovery](#6-backup--recovery)
   - 6.1 Backup Schedule and Location
   - 6.2 Manual Database Backup
   - 6.3 Schedule the Automation Script
   - 6.4 Restore a Database Backup
7. [Monitoring & Logs](#7-monitoring--logs)
8. [Troubleshooting](#8-troubleshooting)
9. [Disaster Recovery Scenarios](#9-disaster-recovery-scenarios)
   - 9.1 Container Failure
   - 9.2 VM Loss
   - 9.3 Database Corruption
10. [Maintenance Calendar](#10-maintenance-calendar)

---

# 1. EXECUTIVE SUMMARY

This operational manual provides the technical documentation and procedures for deploying, securing, and maintaining a production-ready **WordPress and MySQL application stack**.

The infrastructure runs on **Ubuntu Server 26.04** within a VirtualBox hypervisor, implementing a secure multi-tier architecture designed for reliability, isolation, and data protection.

The environment incorporates the following operational capabilities:

| Component | Description |
|:---|:---|
| **Firewall Security** | UFW configured with a default-deny policy |
| **Containerization** | Docker-based application deployment |
| **Database Management** | MySQL 8.0 running in an isolated container |
| **Persistent Storage** | Docker named volumes for data preservation |
| **Network Configuration** | Bridged networking for LAN accessibility |
| **Disaster Recovery** | Automated backup system scheduled through Cron |

The system is designed to provide a manageable, secure, and maintainable cloud infrastructure environment while demonstrating enterprise cloud architecture principles.

---

# 2. ARCHITECTURE OVERVIEW

## 2.1 Infrastructure Architecture

The project implements a six-layer architecture, separating the physical host, virtualization environment, operating system, application services, storage, and automation processes.

**Reference Architecture Diagram:**

> Insert `architecture-diagram.png` here.

## 2.2 Architecture Components

| Layer | Component | Function |
|:---:|:---|:---|
| 01 | **Host Machine** | Laptop running VirtualBox |
| 02 | **Hypervisor** | VirtualBox with Bridged Network Adapter |
| 03 | **Virtual Machine** | Ubuntu Server 26.04 with UFW default-deny firewall |
| 04 | **Containers** | `wp-app` (Port 80) and `wp-mysql` (Internal Port 3306) |
| 05 | **Storage** | Docker named volumes `wp_data` and `db_data` |
| 06 | **Automation** | Cron scheduler executing `automation-script.sh` at 02:00 |

## 2.3 Application Stack

The deployed environment consists of two primary Docker containers:

**WordPress Application — `wp-app`**

- Hosts the WordPress web application.
- Exposes HTTP traffic through Port 80.
- Connects to the MySQL database through the internal Docker network.

**MySQL Database — `wp-mysql`**

- Stores WordPress application data.
- Uses MySQL 8.0.
- Operates through internal Port 3306.
- Uses persistent Docker storage to protect database information.

**Data Persistence:**

| Docker Volume | Purpose |
|:---|:---|
| `wp_data` | Stores WordPress application files |
| `db_data` | Stores MySQL database files |

---

# 3. PREREQUISITES

Before deployment, ensure that the following hardware, software, and accounts are available.

## 3.1 Hardware Requirements

| Resource | Minimum Requirement |
|:---|:---|
| RAM | 4 GB |
| Processor | 2 vCPU |
| Storage | 25 GB Disk Space |
| Network | Active LAN or Internet Connection |

## 3.2 Software Requirements

| Software | Version / Requirement |
|:---|:---|
| VirtualBox | Version 7.2.22 |
| Operating System | Ubuntu Server 26.04 |
| Container Platform | Docker Engine |
| Application | WordPress |
| Database | MySQL 8.0 |
| Version Control | Git |

## 3.3 Required Accounts

- Active GitHub account.
- Access to the project repository.
- Administrative access to the Ubuntu Server virtual machine.

---

# 4. DEPLOYMENT PROCEDURE

This section outlines the step-by-step process for provisioning the virtual machine, installing Docker, and deploying the application stack.

## 4.1 Provision Virtual Machine

**Objective:** Create and configure the Ubuntu Server virtual machine.

**Procedure:**

1. Open VirtualBox and create a new virtual machine.
2. Configure the virtual machine with the following resources:

   | Configuration | Assigned Value |
   |:---|:---|
   | Operating System | Ubuntu Server 26.04 |
   | RAM | 4 GB |
   | CPU | 2 vCPU |
   | Disk | 25 GB |
   | Network Adapter | Bridged Adapter |

3. Mount the Ubuntu Server 26.04 ISO file.
4. Start the virtual machine and complete the Ubuntu installation.
5. Enable OpenSSH during installation.
6. Log in to the Ubuntu Server terminal.

**Update the system packages:**

```bash
sudo apt update && sudo apt upgrade -y
```

**Expected Result:** Ubuntu Server is successfully installed, updated, and accessible through SSH.

---

## 4.2 Install Docker

**Objective:** Install Docker Engine and the Docker Compose plugin to support containerized application deployment.

### Step 1 — Install Docker via Snap

```bash
sudo snap install docker
```

### Step 2 — Wait for Installation to Finish

The terminal will show a progress bar. Once it completes, you will see a message similar to:

```text
docker 2x.x.x from Canonical✓ installed
```

Run this command to restart the Docker Snap:

```bash
sudo snap disable docker && sudo snap enable docker
```

### Step 3 — Give Your User Permission

Docker via Snap runs under a specific security profile. Add your user to the Docker group so you do not have to type `sudo` for every Docker command.

```bash
sudo addgroup --system docker
sudo adduser $USER docker
newgrp docker
```

### Step 4 — Test Docker

Run the classic test:

```bash
docker run hello-world
```

If you see **"Hello from Docker!"**, Docker is ready to proceed.

### Installation Verification

```bash
docker --version
docker compose version
```

**Expected Result:** Docker Engine and Docker Compose are installed and ready for deployment.

---

## 4.3 Deploy Application Stack

**Objective:** Retrieve the project repository, configure environment variables, and deploy the WordPress and MySQL containers.

### Step 1 — Clone the Repository

```bash
git clone <repo>
```

### Step 2 — Navigate to the Project Directory

```bash
cd Laboratory-10-Enterprise-Cloud-Architect
```

### Step 3 — Configure Environment Variables

Create a local environment configuration file using the provided example.

```bash
cp .env.example .env
```

Edit the configuration:

```bash
nano .env
```

**Important:** Configure the required database credentials and application environment variables. Do not expose actual passwords or sensitive credentials in the public GitHub repository.

### Step 4 — Start the Application Stack

Execute the Docker Compose command:

```bash
docker compose up -d
```

The `-d` option runs the containers in detached mode.

### Step 5 — Verify Container Status

```bash
docker compose ps
```

**Expected Result:** The WordPress and MySQL containers should be running successfully.

---

## 4.4 Verify Container Status

**Objective:** Confirm that the application containers are running, the WordPress website responds, and the application logs do not show unresolved database connection errors.

Run the following commands:

```bash
docker compose ps
docker compose logs --tail=100
curl -I http://localhost
```

**Expected Result:** WordPress and MySQL containers are running, the website responds, and the logs do not show unresolved database connection errors.

---

## 4.5 Verify Data Persistence

**Objective:** Confirm that WordPress application data and MySQL database data remain available after the virtual machine restarts.

**Procedure:**

1. Create a test WordPress post.
2. Reboot the virtual machine.
3. After reboot, return to the project directory.
4. Start the application stack again.
5. Verify the containers and check the website.
6. Confirm that the test post remains available.

Reboot the virtual machine:

```bash
sudo reboot
```

After reboot, return to the project directory and start the containers:

```bash
docker compose up -d
docker compose ps
```

**Expected Result:** The test WordPress post remains available after reboot because `wp_data` and `db_data` are persistent named volumes.

Capture evidence only after the persistence test has actually succeeded.

---

# 5. SECURITY CONTROLS

This section describes the security controls used to protect the virtual machine, application, database, and container environment.

## 5.1 Configure UFW Firewall

The project design uses a default-deny inbound policy and permits only the required SSH and HTTP access. Allow SSH before enabling UFW, especially when connected remotely.

Install UFW:

```bash
sudo apt install -y ufw
```

Configure the firewall:

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22/tcp comment 'SSH administration'
sudo ufw allow 80/tcp comment 'WordPress HTTP'
sudo ufw --force enable
sudo ufw status verbose
```

**Important Security Reminder:**

Do not open port `3306`. MySQL should remain on the internal Docker bridge network and must not have a `3306:3306` port mapping in Docker Compose.

## 5.2 SSH and Account Security

- Use strong, unique passwords and restrict administrative accounts.
- Where configured, use SSH key authentication and test it before disabling password login.
- Disable direct root login only after validating the SSH configuration and confirming another administrative login works.

Validate the SSH configuration:

```bash
sudo sshd -t
sudo systemctl status ssh
```

## 5.3 Database and Secret Security

- Use a dedicated non-root MySQL account for WordPress.
- Store credentials in `.env`, apply `chmod 600 .env`, and exclude `.env` from Git.
- Never put real passwords in screenshots, public repositories, or the manual.
- Do not publish MySQL port 3306 to the host or LAN.

Set the environment file permissions:

```bash
chmod 600 .env
```

## 5.4 WordPress and Docker Security

- Use a unique WordPress administrator password and limit administrator privileges.
- Keep WordPress core, themes, and plugins updated; remove unused plugins and themes.
- Use trusted container images and review updates before applying them.
- Before exposing the site outside a controlled LAN demo, configure HTTPS with a trusted TLS certificate. The current HTTP setup does not encrypt browser traffic.
- Docker group membership grants powerful host access; give it only to trusted administrators.

---

# 6. BACKUP & RECOVERY

The project plan specifies a daily database backup at 02:00 using Cron, compressed SQL dumps, and seven-day retention. Confirm the script, path, container name, database name, and Linux username match the deployed project.

## 6.1 Backup Schedule and Location

| Item | Configuration |
|:---|:---|
| Schedule | Daily at 02:00 |
| Method | `mysqldump` compressed with `gzip` |
| Example Location | `/home/architect/backups/` |
| Retention | 7 days |
| Log | Use a log path writable by the Cron user |

## 6.2 Manual Database Backup

**Objective:** Create a compressed backup of the WordPress MySQL database.

The example assumes:

- Container name: `wp-mysql`
- Database name: `wordpress`
- A configured `MYSQL_ROOT_PASSWORD` environment variable inside the container.

Create the backup directory:

```bash
mkdir -p "$HOME/backups"
```

Create a compressed database backup:

```bash
docker exec wp-mysql sh -c 'exec mysqldump -u root -p"$MYSQL_ROOT_PASSWORD" wordpress' | gzip > "$HOME/backups/wordpress_$(date +%F_%H-%M-%S).sql.gz"
```

Verify the backup file:

```bash
ls -lh "$HOME/backups/"
```

**Expected Result:** A compressed SQL backup file is created in the backups directory.

## 6.3 Schedule the Automation Script

**Objective:** Schedule the automated backup script to run daily at 02:00.

Make the project script executable:

```bash
chmod +x automation-script.sh
```

Open the user's crontab:

```bash
crontab -e
```

Add the following Cron entry. Replace the sample path with the actual location of the script and log file:

```cron
0 2 * * * /home/architect/enterprise-cloud/automation-script.sh >> /home/architect/wp-backup.log 2>&1
```

Verify the scheduled task:

```bash
crontab -l
sudo systemctl status cron
tail -n 50 /home/architect/wp-backup.log
```

The supplied mission guide's script checks whether MySQL is running, creates a compressed dump, logs success or failure, and removes database backups older than seven days.

Test the script manually and verify that the resulting backup file is non-empty.

**Expected Result:** The backup script is executable, the Cron job is registered, and the log can be checked for backup activity.

## 6.4 Restore a Database Backup

**Objective:** Restore a database from a verified compressed SQL backup.

**Important:** Restore only after confirming the correct backup file. Restoration can overwrite current database content; test in a separate environment when possible.

Example restore command:

```bash
gunzip -c "$HOME/backups/wordpress_YYYY-MM-DD_HH-MM-SS.sql.gz" | docker exec -i wp-mysql sh -c 'exec mysql -u root -p"$MYSQL_ROOT_PASSWORD" wordpress'
```

Replace the date and time in the filename with the actual backup file.

**Recovery Limitation:**

A database dump does not include all WordPress uploads, themes, and plugins. Back up the `wp_data` volume separately and document and test its restore method before claiming complete disaster recovery.

Keep a second copy of backups outside the virtual machine.

---

# 7. MONITORING & LOGS

**Objective:** Monitor container health, application logs, system resources, firewall status, and automated backup activity.

Use these commands during routine checks or when diagnosing an issue:

### Check Container Status

```bash
docker compose ps
```

### View Live Container Logs

```bash
docker compose logs -f
```

### Monitor Container Resource Usage

```bash
docker stats
```

### Check Disk Space

```bash
df -h
```

### Check Memory Usage

```bash
free -h
```

### Check Firewall Status

```bash
sudo ufw status verbose
```

### Check Cron Service

```bash
sudo systemctl status cron
```

### Review Backup Logs

```bash
tail -n 50 /home/architect/wp-backup.log
```

**Monitoring Checklist:**

- Check that containers remain running.
- Review logs for repeated failures.
- Confirm that sufficient disk space is available.
- Verify that UFW is active.
- Confirm that backup files are being created.
- Replace example log paths with the path configured in the script.

---

# 8. TROUBLESHOOTING

The following table lists common problems, possible causes, and recommended diagnostic or corrective actions.

| Symptom | Diagnosis / Fix |
|:---|:---|
| **Website unavailable / connection refused** | Run `docker compose ps`; check the VM IP, port 80 mapping, UFW, and WordPress logs. Start services with `docker compose up -d`. |
| **WordPress database connection error** | Check `.env`, database name/user/password, service name, shared Docker network, and MySQL logs. |
| **MySQL container restarts** | Review `docker compose logs db`; check credentials, disk space, and volume issues. |
| **SSH connection fails** | Check `ip a`, SSH service status, bridged networking, and UFW rule for the actual SSH port. |
| **Docker permission denied** | Use `sudo docker` or log in again after adding the trusted user to the Docker group. |
| **Backup not running** | Check `crontab -l`, Cron service status, executable permission, absolute paths, file permissions, and backup log. |
| **Disk space low** | Use `df -h` and `docker system df`; inspect before removing anything. Do not delete persistent volumes casually. |

**Important:** Diagnose the issue before removing containers, images, or volumes. Avoid deleting persistent data when troubleshooting.

---

# 9. DISASTER RECOVERY SCENARIOS

This section describes the recovery procedures for common infrastructure failures.

## 9.1 Container Failure

The `restart: unless-stopped` policy can restart containers after an unexpected stop.

**Recovery Procedure:**

1. Check the container status.
2. Review the container logs.
3. Start the application stack if required.
4. Verify that the WordPress website is accessible.

Commands:

```bash
docker compose ps
docker compose logs --tail=100
docker compose up -d
```

**Expected Result:** The containers return to a running state and the application becomes accessible.

## 9.2 VM Loss

**Scenario:** The Ubuntu virtual machine becomes unavailable or is lost.

**Recovery Procedure:**

1. Recreate the virtual machine.
2. Install Ubuntu Server.
3. Install Docker.
4. Retrieve the project repository.
5. Configure a new protected `.env` file.
6. Deploy the Docker Compose stack.
7. Restore the latest valid database backup.
8. Restore the WordPress files backup.
9. Validate the website before returning it to service.

**Important:** Recovery requires both the database backup and the WordPress files backup. A database dump alone does not restore all application files.

## 9.3 Database Corruption

**Scenario:** The MySQL database becomes corrupted or its data is no longer usable.

**Recovery Procedure:**

1. Preserve a copy of the current state if possible.
2. Identify the most recent verified database dump.
3. Restore the backup using the procedure in Section 6.4.
4. Verify that the database and WordPress application are working.

**Important:** Do not delete `db_data` or `wp_data` unless an authorized recovery plan requires it and a valid backup has been confirmed.

---

# 10. MAINTENANCE CALENDAR

The following maintenance schedule provides routine tasks for keeping the cloud infrastructure secure, stable, and operational.

| Task | Frequency |
|:---|:---|
| Verify backup files and log | Daily |
| Review container status/logs | Daily / as needed |
| Apply Ubuntu security updates | Weekly or per policy |
| Review WordPress core, themes, and plugins | Monthly and when security updates are released |
| Review/pull tested Docker image updates | Monthly, after backup |
| Rotate credentials | Quarterly and after suspected exposure |
| Test database and file restore | Periodically; document result |

## Operational Commands

The following commands are useful for routine Docker application management.

| Command | Purpose |
|:---|:---|
| `docker compose up -d` | Start the application containers |
| `docker compose down` | Stop containers; named volumes remain |
| `docker compose restart` | Restart services |
| `docker compose ps` | Display container status |
| `docker compose logs -f` | View live container logs |

**Important:** Do not use `docker compose down -v` for routine shutdown because the `-v` option removes named volumes and can delete persistent application and database data.

---

<div align="center">

**END OF OPERATIONAL MANUAL**

*Enterprise Cloud Architect · CCM101*

</div>
'''
