variable "name" {
  description = "Azure Bastion name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
}

variable "subnet_id" {
  description = "Azure Bastion subnet ID"
  type        = string
  default     = null
  }

variable "public_ip_address_id" {
  description = "Public IP ID for Azure Bastion"
  type        = string
  default     = null
}

variable "sku" {
  description = "Azure Bastion SKU"
  type        = string
  default     = "Developer"
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}