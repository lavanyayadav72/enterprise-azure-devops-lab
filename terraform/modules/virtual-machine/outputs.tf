output "id" {
  value = azurerm_linux_virtual_machine.this.id
}

output "name" {
  value = azurerm_linux_virtual_machine.this.name
}

output "private_ip" {
  value = azurerm_linux_virtual_machine.this.private_ip_address
}

output "principal_id" {
  description = "Managed Identity Principal ID"
  value       = azurerm_linux_virtual_machine.this.identity[0].principal_id
}

output "tenant_id" {
  description = "Managed Identity Tenant ID"
  value       = azurerm_linux_virtual_machine.this.identity[0].tenant_id
}

output "vm_id" {

  description = "Virtual machine resource ID"

  value = azurerm_linux_virtual_machine.this.id

}