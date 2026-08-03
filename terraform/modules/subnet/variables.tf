variable "name" {
  description = "Subnet name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
}

variable "virtual_network_name" {
  description = "Virtual Network name"
  type        = string
}

variable "address_prefixes" {
  description = "Subnet address prefixes"
  type        = list(string)
}

variable "default_outbound_access_enabled" {
  type    = bool
  default = true
}

variable "private_endpoint_network_policies" {

  type = string

  default = "Enabled"

}