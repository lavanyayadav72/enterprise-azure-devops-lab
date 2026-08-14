variable "name" {
  description = "Diagnostic setting name"
  type        = string
}

variable "target_resource_id" {
  description = "Resource ID of the Storage Account"
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "Log Analytics Workspace ID"
  type        = string
}