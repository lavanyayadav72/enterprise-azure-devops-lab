# 07 - Compute Infrastructure Foundation: Contoso Financial Services

## 1. Architecture Overview & Logical Topology

The compute tier for **Contoso Financial Services** provides isolated execution environments for core banking APIs, microservices, and management workloads. Compute resources reside entirely within private VNet subnets and enforce zero direct public internet ingress.

```text
                               +----------------------------------------------------+
                               |                Contoso VNet (10.10.0.0/16)          |
                               |                                                    |
  [ Azure Bastion Subnet ]     |   [ App Subnet ]             [ Management Subnet ] |
  (10.10.250.0/27)             |   (10.10.2.0/24)             (10.10.10.0/24)       |
  +----------------------+     |   +-------------------+      +-------------------+ |
  |  Azure Bastion Host  |----->---|  Application VMs  |----->| Administrative    | |
  |  (PaaS Proxy)        | TLS |   |  / Worker Nodes   | SSH  | Jumpbox Host      | |
  +----------------------+     |   +-------------------+      +-------------------+ |
                               |             |                                      |
                               +-------------|--------------------------------------+
                                             |
                                             v (System-Assigned Managed Identity)
                               +----------------------------------------------------+
                               |       Azure Key Vault / Azure Storage Account      |
                               +----------------------------------------------------+