output "id" {
  description = "NAT Gateway ID"
  value       = azurerm_nat_gateway.this.id
}

output "name" {
  description = "NAT Gateway name"
  value       = azurerm_nat_gateway.this.name
}