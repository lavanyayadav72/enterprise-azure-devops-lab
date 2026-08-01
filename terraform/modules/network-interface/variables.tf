variable "name" {
  description = "Network Interface name"
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
  description = "Subnet ID"
  type        = string
}

variable "private_ip_address_allocation" {
  description = "Private IP allocation method"
  type        = string
  default     = "Dynamic"
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}