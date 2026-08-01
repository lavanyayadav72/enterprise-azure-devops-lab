# 07 - Compute Infrastructure & Foundation

## 1. Purpose

The compute layer provides a secure, reliable, and scalable hosting environment for Contoso Financial Services' core application workloads. Designed following Azure landing zone best practices, this foundation balances infrastructure immutability with automated configuration.

Key objectives include:

* **Secure Hosting:** Provide isolated, hardened compute environments for banking workloads with zero direct exposure to the public internet.
* **Modular Infrastructure:** Leverage reusable Terraform modules for Virtual Machines, Network Interfaces, and Managed Disks to maintain environment consistency across Dev, Staging, and Production.
* **Automated Bootstrapping:** Utilize `cloud-init` scripts to automate post-provisioning configuration, security agent installation, and application bootstrapping without manual intervention.
* **Extensible Scaling Foundation:** Lay the groundwork for future horizontal scaling, high availability, and automated CI/CD deployment pipelines.

---

## 2. Compute Architecture

The compute tier is isolated within dedicated private subnets. All incoming and outgoing traffic is controlled via Network Security Groups (NSGs), while platform services handle identity and persistent storage bindings.

```text
                                Web Tier
                                   │
                                Linux VM
                                   │
         ┌─────────────────────────┼─────────────────────────┐
         │                         │                         │
         ▼                         ▼                         ▼
  Network Interface          Managed Disk            Managed Identity
  (NIC + Static IP)      (10GB Data Disk / Zone 1)   (System-Assigned)
         │                                                   │
         ▼                                                   ▼
    Web Subnet                                       Azure Resource Access
  (10.10.2.0/24)                                     (Key Vault / Storage)
         │
         ▼
    Virtual Network
   (10.10.0.0/16)