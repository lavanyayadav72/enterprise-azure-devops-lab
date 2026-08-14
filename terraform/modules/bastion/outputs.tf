output "id" {
  description = "Azure Bastion resource ID"
  value       = azurerm_bastion_host.this.id
}

output "name" {
  description = "Azure Bastion name"
  value       = azurerm_bastion_host.this.name
}