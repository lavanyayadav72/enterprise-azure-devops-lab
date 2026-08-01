output "id" {
  value = azurerm_managed_disk.this.id
}

output "name" {
  description = "Managed disk name"
  value       = azurerm_managed_disk.this.name
}