# 06 - Network Architecture & Topology Design

## 🏛️ Our Banking Network
To support secure, isolated banking applications for **Contoso Financial Services**, we adopt a **hub-and-spoke-inspired VNet layout**. This design enforces strict network segregation while maintaining simplicity for our enterprise lab environment.

```text
                     Contoso VNet
                     10.10.0.0/16
                          │
    ┌──────────────┬──────┴───────┬──────────────┐
    │              │              │              │
    ▼              ▼              ▼              ▼
Web Subnet     App Subnet     Data Subnet    Management
10.10.1.0/24  10.10.2.0/24   10.10.3.0/24   10.10.10.0/24