# 01 - Project Overview: Contoso Financial Services

## Executive Summary
**Contoso Financial Services** is a global financial institution delivering modern, digital banking solutions to millions of retail and corporate clients worldwide. 

The **Enterprise Azure DevOps Lab** (`enterprise-azure-devops-lab`) represents the next-generation cloud foundation for Contoso Financial Services. This platform transitions Contoso from legacy infrastructure to a secure, highly available, fully automated, and compliant cloud environment hosted on **Microsoft Azure**.

---

## Business Objectives

1. **Digital Banking Acceleration:** Enable rapid, automated deployment of core customer-facing applications without sacrificing operational stability.
2. **Regulatory & Security Compliance:** Adhere to global financial industry benchmarks including **PCI-DSS Level 1**, **ISO/IEC 27001**, **SOC 2 Type II**, and **GDPR/FINRA** data retention regulations.
3. **High Availability & Zero Downtime:** Maintain **99.99% availability** across multi-region deployments with continuous state replication and automated failover capabilities.
4. **Operational Resilience:** Implement strict DevSecOps pipelines, automated drift detection, and proactive incident response runbooks to minimize mean time to recovery (MTTR).

---

## Core Application Suite

The cloud platform supports four mission-critical workload tiers:

| Application | Primary Purpose | Security & Hosting Tier |
| :--- | :--- | :--- |
| **Customer Banking Portal** | Customer authentication, account overview, funds transfers, and statement downloads | External-facing / Azure App Gateway WAF + AKS |
| **Payment Processing System** | High-throughput transaction clearing, payment validation, external gateway integration (SWIFT/Visa) | Internal PCI-DSS VNet / AKS + Cosmos DB |
| **Employee Portal** | Customer support workflows, account administration, regulatory reporting, and internal audits | Internal / Zero Trust Bastion + Entra ID RBAC |
| **Document Management System (DMS)** | Secure archival of KYC/AML records, customer statements, and financial audit logs | Immutable Azure Blob Storage + Key Vault CMK |

---

## Architecture & Engineering Principles

### 1. Everything as Code (EaC)
* **Infrastructure as Code (IaC):** 100% of Azure cloud infrastructure is managed declaratively using **Terraform** / **OpenTofu**. Zero manual configurations in the Azure Portal ("No ClickOps").
* **Pipeline as Code:** Continuous Integration and Continuous Deployment (CI/CD) workflows executed via **GitHub Actions**.

### 2. Zero Trust Security Model
* **Network Isolation:** Microservices operate inside a Hub-and-Spoke Virtual Network topology guarded by Azure Firewall and Network Security Groups (NSGs).
* **Identity Governance:** Granular Role-Based Access Control (RBAC) powered by Microsoft Entra ID with passwordless Managed Identities and Workload Identities.
* **Data Encryption:** TLS 1.3 enforced for data-in-transit; Customer-Managed Keys (CMK) via Azure Key Vault for data-at-rest.

### 3. Observability & SRE Culture
* **Centralized Telemetry:** Real-time metrics, audit logs, and distributed traces aggregated using **Prometheus**, **Grafana**, and **Datadog**.
* **Failure Simulation:** Continuous testing through chaotic failure injection, runbook testing, and blameless postmortems.

---

## Target Architecture Blueprint

```text
                               +-----------------------------+
                               |     Azure Front Door /      |
                               |    Web Application Firewall |
                               +--------------+--------------+
                                              |
                                              v
+-----------------------------------------------------------------------------------+
| HUB VNET (rg-contoso-hub-prod)                                                    |
|  - Azure Firewall                                                                 |
|  - Azure Bastion Host                                                             |
|  - Log Analytics Workspace                                                        |
+--------------------------------------+--------------------------------------------+
                                       |
                   +-------------------+-------------------+
                   | Peering                               | Peering
                   v                                       v
+---------------------------------------+ +-----------------------------------------+
| SPOKE VNET: PRODUCTION (rg-prod)      | | SPOKE VNET: DEVELOPMENT (rg-dev)        |
|  - AKS Cluster (Banking & Payments)   | |  - AKS Cluster (Dev Workloads)          |
|  - Private Endpoints (Key Vault / DB) | |  - Dev Storage & Test DBs               |
|  - Immutable Blob Storage (DMS)       | |                                         |
+---------------------------------------+ +-----------------------------------------+