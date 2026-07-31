# 05 - Terraform State Management: Contoso Financial Services

## 1. Purpose
[cite_start]The **Terraform State File** (`.tfstate`) serves as the single source of truth mapping declared Terraform code to real-world cloud infrastructure provisioned in **Microsoft Azure**[cite: 200]. 

[cite_start]For **Contoso Financial Services**, safe and centralized state management is a core operational and security requirement[cite: 45, 52, 53]. Because state files contain metadata, resource mappings, and potentially sensitive configuration attributes, managing state correctly ensures:
* [cite_start]**Concurrency & Safety:** Prevents multiple engineers or CI/CD pipelines from modifying the same infrastructure simultaneously, eliminating race conditions and state corruption[cite: 53].
* [cite_start]**Disaster Recovery & Auditability:** Protects infrastructure tracking against accidental local file deletion and maintains an auditable history of infrastructure evolution.
* [cite_start]**Compliance Alignment:** The architecture follows security practices commonly required in regulated industries, including access control, encryption, auditing, and secure state management.

---

## 2. Local vs. Remote State

Storing state files locally on individual workstations poses severe operational risks. [cite_start]Contoso Financial Services strictly mandates the use of **Azure Remote Backend Storage**[cite: 52, 53].

| Feature / Criteria | Local State | Remote State (Azure Storage) |
| :--- | :--- | :--- |
| **Storage Location** | Stored on engineer's local laptop | Stored centrally in Azure Blob Storage |
| **User Access** | Single user only | Multiple engineers and CI/CD pipelines |
| **Risk Profile** | High risk of data loss or file corruption | Protected storage with versioning & soft delete |
| **Collaboration** | No collaboration support (leads to drift) | Native team collaboration & state locking |
| **Security** | Unencrypted local disk storage | Encryption at rest, TLS 1.2+ in transit, RBAC |

---

## 3. Enterprise State Architecture

The logical flow below illustrates how engineers and automated CI/CD pipelines interact with the centralized Azure Remote State Storage Backend:

```text
+-------------------------------------------------------------+
|                      Engineer Laptop                        |
|                                                             |
|                    [ Terraform Code ]                       |
+------------------------------+------------------------------+
                               |
                               |  1. Runs terraform plan / apply
                               v
+-------------------------------------------------------------+
|               Azure Remote State Backend                    |
|             (rg-contoso-tfstate-bootstrap)                  |
|                                                             |
|   +-----------------------------------------------------+   |
|   |         Azure Blob Storage Account (stcontosotf)    |   |
|   |                                                     |   |
|   |   +---------------------------------------------+   |   |
|   |   |       Blob Container: "tfstate"             |   |   |
|   |   |                                             |   |   |
|   |   |   [ dev.tfstate ]    [ qa.tfstate ]        |   |   |
|   |   |   [ uat.tfstate ]    [ prod.tfstate ]       |   |   |
|   |   +---------------------------------------------+   |   |
|   +-----------------------------------------------------+   |
|                                                             |
|   +-----------------------------------------------------+   |
|   |    Managed Identity
                 |
                 |
                RBAC
                 |
                 |
              Azure Storage Account       |   |
|   +-----------------------------------------------------+   |
+-------------------------------------------------------------+

## State Locking

Azure Blob Storage backend provides state locking capability to prevent simultaneous Terraform operations.

Example:

Engineer A:
terraform apply
        |
        |
State Lock acquired


Engineer B:
terraform apply
        |
        |
Operation blocked until lock released


## State File Protection

Terraform state files must never be committed to source control.

The repository should include:

.gitignore

*.tfstate
*.tfstate.*
.terraform/