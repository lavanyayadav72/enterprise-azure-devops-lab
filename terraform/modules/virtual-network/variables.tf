variable "name" {
  description = "Virtual Network name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group where the VNet will be created"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "address_space" {
  description = "Address space for the VNet"
  type        = list(string)
}

variable "tags" {
  description = "Tags applied to the Virtual Network"
  type        = map(string)
  default     = {}
}

##variable "virtual_network_id" {

  ##description = "VNet ID for DNS link"

  ##type = string

##}