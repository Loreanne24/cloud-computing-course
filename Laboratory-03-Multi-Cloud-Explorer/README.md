# Laboratory 03 – Multi-Cloud Explorer

## Mission 3: Become a Multi-Cloud Explorer

This laboratory activity explores and compares three major cloud computing platforms:

- Amazon Web Services (AWS)
- Microsoft Azure
- Google Cloud Platform (GCP)

The objective is to identify their core services, compare their capabilities, and recommend suitable cloud solutions based on different business requirements.

## Learning Objectives

- Explore major public cloud platforms.
- Identify core services offered by AWS, Azure, and GCP.
- Compare cloud services across providers.
- Analyze business requirements and recommend appropriate cloud solutions.
- Practice technical documentation using Markdown.

## Continue Your Linux Investigation

For this checkpoint, a Linux server was launched using a KillerCoda Playground. 
Linux commands were used to identify the operating system, CPU information, memory, and available disk space.

### Linux System Information

#### 1. Operating System

Command used:
cat /etc/os-release
<img width="1919" height="1078" alt="image" src="https://github.com/user-attachments/assets/d02923ed-e92e-4266-b687-115923450ea0" />

#### 2. CPU Information

Command used:
lscpu
<img width="1919" height="1078" alt="image" src="https://github.com/user-attachments/assets/b98f37cb-af1c-49b5-aaac-d6e672f8bb29" />

<img width="1917" height="1077" alt="image" src="https://github.com/user-attachments/assets/7a2de447-19b1-4603-954b-3270063be382" />


#### 3. Memory

Command used:
free -h

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/d3a3f268-b3cf-47d8-a9a9-4026c90fe9a0" />

#### 4. Disk Space

Command used:
df -h

<img width="1918" height="1077" alt="image" src="https://github.com/user-attachments/assets/2a6a9a44-f5e7-44bc-bbb6-aec355b71299" />

## Cloud Migration

If this Linux server were migrated to the cloud, it could be hosted using virtual machine services from AWS, Microsoft Azure, and Google Cloud Platform (GCP).

| Cloud Provider | Service | Description |
|---|---|---|
| **AWS** | **Amazon EC2** | A scalable virtual server service that can run various Linux distributions in the AWS cloud. |
| **Microsoft Azure** | **Azure Virtual Machines** | Provides virtual machines that support Linux operating systems and allows users to configure CPU, memory, storage, and networking. |
| **Google Cloud Platform (GCP)** | **Google Compute Engine** | Provides customizable and scalable virtual machines for running Linux servers and applications. |

### Recommendation

The Linux server can be migrated to **Amazon EC2, Azure Virtual Machines, or Google Compute Engine** because all three services support Linux-based virtual machines. The existing server's CPU, memory, disk, and operating system requirements can be used to select an appropriate virtual machine size and configuration. The final cloud provider should be selected based on factors such as cost, performance, scalability, location, and the organization's existing cloud environment.

