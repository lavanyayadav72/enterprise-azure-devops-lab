variable "name" {
  type        = string
  description = "Name of the Application Gateway"
}

variable "location" {
  type        = string
  description = "Azure region for deployment"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "sku_name" {
  type        = string
  description = "Application Gateway SKU name"
  default     = "Standard_v2"
}

variable "sku_tier" {
  type        = string
  description = "Application Gateway SKU tier"
  default     = "Standard_v2"
}

variable "capacity" {
  type        = number
  description = "Capacity or instance count"
  default     = 1
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}

variable "public_ip_id" {
  type        = string
  description = "Public IP resource ID"
}

variable "gateway_subnet_id" {
  type        = string
  description = "Application Gateway dedicated subnet ID"
}

variable "backend_ip_addresses" {
  type        = list(string)
  description = "Backend server private IP addresses"
}

variable "frontend_port" {
  type        = number
  description = "Frontend listener port"
  default     = 80
}

variable "backend_port" {
  type        = number
  description = "Backend server port"
  default     = 80
}

variable "backend_protocol" {
  type        = string
  description = "Backend communication protocol"
  default     = "Http"
}

variable "frontend_protocol" {
  type        = string
  description = "Frontend listener protocol"
  default     = "Http"
}

variable "request_timeout" {
  type        = number
  description = "Backend request timeout in seconds"
  default     = 60
}

variable "routing_rule_priority" {
  type        = number
  description = "Routing rule priority"
  default     = 100
}

variable "probe_interval" {
  type        = number
  description = "Health probe interval in seconds"
  default     = 30
}

variable "probe_timeout" {
  type        = number
  description = "Health probe timeout in seconds"
  default     = 30
}

variable "probe_unhealthy_threshold" {
  type        = number
  description = "Failed probe attempts before marking backend unhealthy"
  default     = 3
}

variable "probe_path" {
  type        = string
  description = "Health probe request path"
  default     = "/"
}

variable "waf_enabled" {
  description = "Enable Web Application Firewall"
  type        = bool
  default     = true
}

variable "waf_mode" {
  description = "WAF mode Detection or Prevention"
  type        = string
  default     = "Prevention"
}