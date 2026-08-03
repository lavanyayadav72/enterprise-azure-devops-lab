variable "environment" {
  description = "Environment name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "vnet_name" {
  type = string
}

variable "vnet_address_space" {
  type = list(string)
}

variable "admin_username" {
  type = string
}

variable "public_key" {
  type = string
}


variable "priority" {
  type        = string
  description = "VM Priority: 'Regular' or 'Spot'"
  default     = "Spot"
}

variable "eviction_policy" {
  type        = string
  description = "Eviction policy for Spot VM: 'Deallocate' or 'Delete'"
  default     = "Deallocate"
}

variable "max_bid_price" {
  type        = number
  description = "Maximum bid price for Spot VM (-1 for standard rate)"
  default     = -1
}

variable "sql_admin_username" {
  type        = string
  description = "Administrator username for the Azure MSSQL Server"
  default     = "sqladmin"
}

variable "sql_admin_password" {
  type        = string
  description = "Administrator password for the Azure MSSQL Server"
  sensitive   = true
}