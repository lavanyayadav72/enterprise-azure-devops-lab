variable "name" {
  description = "NAT Gateway name"
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

variable "sku_name" {
  description = "NAT Gateway SKU"
  type        = string
  default     = "Standard"
}

variable "idle_timeout_in_minutes" {
  description = "NAT Gateway idle timeout"
  type        = number
  default     = 4
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}

variable "public_ip_address_id" {
  description = "Public IP ID associated with the NAT Gateway"
  type        = string
}