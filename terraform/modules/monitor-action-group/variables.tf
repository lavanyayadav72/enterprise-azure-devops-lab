variable "name" {

  type = string

}


variable "resource_group_name" {

  type = string

}


variable "email_address" {

  type = string

}


variable "tags" {

  type = map(string)

  default = {}

}