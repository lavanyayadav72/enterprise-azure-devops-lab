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