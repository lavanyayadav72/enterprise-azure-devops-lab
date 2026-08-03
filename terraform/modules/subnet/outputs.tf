output "id" {
  value = azurerm_subnet.this.id
}

output "name" {
  value = azurerm_subnet.this.name
}

output "subnet_id" {
  description = "Subnet ID"
  value       = azurerm_subnet.this.id
}
