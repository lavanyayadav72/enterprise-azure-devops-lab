variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "sql_server_name" {
  description = "SQL Server name"
  type        = string
}

variable "administrator_login" {
  description = "SQL administrator username"
  type        = string
}

variable "administrator_password" {
  description = "SQL administrator password"
  type        = string
  sensitive   = true
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "sql_database_name" {

  description = "SQL Database name"

  type = string

}


variable "sql_database_sku" {

  description = "SQL Database SKU"

  type = string

  default = "Basic"

}

variable "private_endpoint_subnet_id" {

  description = "Subnet ID for SQL private endpoint"

  type = string

}


variable "virtual_network_id" {

  description = "VNet ID for DNS link"

  type = string

}