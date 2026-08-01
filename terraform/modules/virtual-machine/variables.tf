variable "name" {
  description = "Virtual Machine name"
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

variable "size" {
  description = "Azure VM size"
  type        = string
}

variable "network_interface_ids" {
  description = "List of NIC IDs"
  type        = list(string)
}

variable "admin_username" {
  description = "Administrator username"
  type        = string
}

variable "public_key" {
  description = "SSH public key"
  type        = string
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}

variable "priority" {
  type        = string
  description = "VM Priority: 'Regular' or 'Spot'"
  default     = "Regular"
}

variable "eviction_policy" {
  type        = string
  description = "Eviction policy for Spot VM: 'Deallocate' or 'Delete'"
  default     = null
}

variable "max_bid_price" {
  type        = number
  description = "Maximum bid price for Spot VM (-1 for standard rate)"
  default     = null
}

variable "custom_data" {
  description = "Cloud-init configuration"
  type        = string
  default     = null
}

variable "zone" {
  description = "Availability Zone"
  type        = string
  default     = "1"
}