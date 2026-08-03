# 08 - Application Delivery Layer: Contoso Financial Services

## 1. Purpose

The Application Delivery Layer provides a highly available, fault-tolerant, and elastic ingress foundation for Contoso Financial Services' multi-tier application stack. By decoupling external client entry points from backend execution environments, this layer ensures continuous application availability and seamless operational scaling.

Key objectives include:

* **Improving High Availability:** Ensure uninterrupted access to core banking web services through active load distribution and proactive health monitoring across Availability Zones.
* **Distributing User Traffic:** Balance inbound network requests dynamically across pool members to optimize resource utilization and prevent individual node saturation.
* **Eliminating Single Points of Failure (SPOFs):** Remove single-instance vulnerabilities by routing traffic exclusively to verified, healthy backend instances.
* **Preparing for Horizontal Scaling:** Establish stateless frontend load balancing capable of transparently integrating with Virtual Machine Scale Sets (VMSS) during traffic surges.

---

## 2. Architectural Overview & Logical Topology

The Application Delivery network topology separates public ingress from internal application logic. Inbound traffic passes through an Azure Load Balancer before reaching the web tier, which then securely communicates downstream with internal application resources.

```text
                                  Internet
                                     │
                                     ▼
                            Azure Load Balancer
                             (Public IP / Port 80/443)
                                     │
                     ┌───────────────┴───────────────┐
                     ▼                               ▼
                 Web VM 1                        Web VM 2
           (Availability Zone 1)           (Availability Zone 2)
                     │                               │
                     └───────────────┬───────────────┘
                                     ▼
                                 App Subnet
                             (10.10.3.0/24)
                                     │
                                     ▼
                                   App VM
                             (Internal Logic)[ Client ]
  
  
  [Internet]
   │
   ▼
[ Azure Load Balancer ] (Performs health probe check; selects healthy node)
   │
   ▼
[ Healthy Web VM ]      (Processes presentation layer / static response)
   │
   ▼
[ Application VM ]     (Executes business rules & core processing)
   │
   ▼
[ Database ]            (State storage - Planned for future sprint)