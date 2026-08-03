output "id" {
  description = "Public IP ID"
  value       = azurerm_public_ip.this.id
}

output "ip_address" {
  description = "Public IP Address"
  value       = azurerm_public_ip.this.ip_address
}