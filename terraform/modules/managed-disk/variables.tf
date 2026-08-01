variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "disk_size_gb" {
  type    = number
  default = 32
}

variable "storage_account_type" {
  type    = string
  default = "Standard_LRS"
}

variable "create_option" {
  type    = string
  default = "Empty"
}

variable "tags" {
  type    = map(string)
  default = {}
}