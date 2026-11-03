
<div align="center">

# CCM101 — CLOUD COMPUTING

## ENTERPRISE CLOUD ARCHITECT
### OPERATIONAL MANUAL

**SECURE MULTI-TIER WEB APPLICATION**

<br>

| Project Information | Details |
|:---|:---|
| **Project** | Secure Multi-Tier Web Application |
| **Application Stack** | WordPress + MySQL 8.0 |
| **Prepared By** | [Your Name(s)] |
| **Section** | BSIT 2A |
| **Instructor** | Jenkielyn C. Torres |
| **Date** | [Month Year] |

<br>

**TECHNICAL DOCUMENTATION · DEPLOYMENT · SECURITY · MAINTENANCE**

</div>

---

# TABLE OF CONTENTS

1. [Executive Summary](#1-executive-summary)
2. [Architecture Overview](#2-architecture-overview)
3. [Prerequisites](#3-prerequisites)
4. [Deployment Procedure](#4-deployment-procedure)
   - 4.1 Provision Virtual Machine
   - 4.2 Install Docker
   - 4.3 Deploy Application Stack

---

# 1. EXECUTIVE SUMMARY

This operational manual provides the technical documentation and procedures for deploying, securing, and maintaining a production-ready **WordPress and MySQL application stack**.

The infrastructure runs on **Ubuntu Server 24.04** within a VirtualBox hypervisor, implementing a secure multi-tier architecture designed for reliability, isolation, and data protection.

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
| 03 | **Virtual Machine** | Ubuntu Server 24.04 with UFW default-deny firewall |
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
| VirtualBox | Version 7.x |
| Operating System | Ubuntu Server 24.04 |
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
   | Operating System | Ubuntu Server 24.04 |
   | RAM | 4 GB |
   | CPU | 2 vCPU |
   | Disk | 25 GB |
   | Network Adapter | Bridged Adapter |

3. Mount the Ubuntu Server 24.04 ISO file.
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

> Insert the verified Docker installation commands from Phase 2.1 here.

**Installation Verification:**

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

<div align="center">

**END OF PROVIDED DEPLOYMENT SECTION**

*Enterprise Cloud Architect · CCM101*

</div>
