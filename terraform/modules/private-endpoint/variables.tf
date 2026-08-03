variable "private_endpoint_name" {
  type = string
}


variable "location" {
  type = string
}


variable "resource_group_name" {
  type = string
}


variable "subnet_id" {
  type = string
}


variable "private_resource_id" {
  type = string
}


variable "subresource_name" {
  type = string
}


variable "tags" {

  type = map(string)

  default = {}

}

variable "private_dns_zone_ids" {

  type = list(string)

  default = []

}