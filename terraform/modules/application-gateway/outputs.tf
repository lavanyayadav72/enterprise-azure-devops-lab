output "id" {
  value = azurerm_application_gateway.this.id
}

output "frontend_ip_configuration_name" {
  value = azurerm_application_gateway.this.frontend_ip_configuration[0].name
}

output "frontend_public_ip" {

  description = "Application Gateway public IP"

  value = azurerm_application_gateway.this.frontend_ip_configuration[0].public_ip_address_id

}