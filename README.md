# Enterprise Azure DevOps Lab
# Enterprise Azure DevOps Lab

[![Build Status](https://img.shields.io/badge/Sprint-0%20Complete-brightgreen)](#project-roadmap)
[![Cloud Provider](https://img.shields.io/badge/Cloud-Microsoft%20Azure-0078D4)](https://azure.microsoft.com/)
[![IaC](https://img.shields.io/badge/IaC-Terraform%20%2F%20OpenTofu-844FBA)](https://www.terraform.io/)
[![Compliance](https://img.shields.io/badge/Compliance-PCI--DSS%20%7C%20ISO%2027001-blue)](#overview)

Welcome to the **Enterprise Azure DevOps Lab** (`enterprise-azure-devops-lab`). This repository serves as the enterprise-grade Infrastructure-as-Code (IaC) and DevSecOps platform powering **Contoso Financial Services**.

---

## 🏛️ Overview

**Contoso Financial Services** is a global financial institution delivering digital banking, payment clearing, and wealth management services to over 5 million personal and corporate clients. 

Operating in a highly regulated industry, this platform provides a secure, highly available (99.99% SLA), automated, and compliant cloud foundation built on **Microsoft Azure**. The platform is engineered according to Zero Trust security principles, strict regulatory standards (**PCI-DSS Level 1**, **ISO 27001**, **GDPR/FINRA**), and Site Reliability Engineering (SRE) best practices.

---

## 🎯 Objectives

* **100% Infrastructure as Code (IaC):** Provision and manage all Azure cloud resources declaratively using Terraform. Zero manual portal changes ("No ClickOps").
* **Zero Trust Security & DevSecOps:** Enforce strict network isolation, Role-Based Access Control (RBAC), passwordless Managed Identities, and secret rotation via Azure Key Vault.
* **Continuous Integration & Delivery (CI/CD):** Automate code linting, static security analysis (`checkov`), and environment deployments via GitHub Actions.
* **Multi-Environment Governance:** Implement complete physical, logical, and state isolation across `dev`, `qa`, `uat`, and `prod` environments.
* **End-to-End Observability:** Establish central logging, real-time metrics, automated alerting, and incident response runbooks using Prometheus, Grafana, and Datadog.

---

## 💼 Core Application Suite

The cloud platform supports four mission-critical business application tiers:

| Application | Purpose | Compliance Scope | Target Hosting Tier |
| :--- | :--- | :--- | :--- |
| **Customer Banking Portal** | Online banking, account dashboard, funds transfers, e-statements | PCI-DSS, SOC 2 | External / Application Gateway WAF + AKS |
| **Payment Processing System** | High-throughput transaction clearing, payment validation, SWIFT/Visa integration | PCI-DSS Level 1 | Core Backend / Isolated VNet + AKS + Cosmos DB |
| **Employee Portal** | Customer support workflows, account management, operational reporting | Internal Audit, GDPR | Internal / Zero Trust Bastion + Entra ID SSO |
| **Document Management System (DMS)** | Secure archival of KYC/AML records, bank statements, and audit logs | KYC/AML, FINRA | Immutable Azure Blob Storage + Key Vault CMK |

---

## 📐 Logical Architecture

Requests flow through a multi-tier defense-in-depth security model before reaching internal microservices and database engines:

```text
Customers (Web / Mobile)
          │
          ▼
       Internet
          │
          ▼
      Edge Layer (Perimeter Security & WAF)
          │
          ▼
   Web Applications (Customer Banking / Portals)
          │
          ▼
Backend APIs / Microservices (Payment Engine / Core Services)
          │
    ┌─────┴─────┐
    ▼           ▼
Databases   Storage (SQL / NoSQL / Immutable Blob)
