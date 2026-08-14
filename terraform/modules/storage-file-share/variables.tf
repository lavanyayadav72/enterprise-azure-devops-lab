variable "name" {
  type = string
}

variable "storage_account_id" {
  type = string
}

variable "quota" {
  description = "File share quota in GB"
  type        = number
  default     = 100
}