resource "azurerm_virtual_network" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  address_space = var.address_space

  tags = var.tags
}

##resource "azurerm_private_dns_zone_virtual_network_link" "sql" {


## name = "sql-dns-link"


##resource_group_name = var.resource_group_name


##private_dns_zone_name = azurerm_private_dns_zone.sql.name


##virtual_network_id = var.virtual_network_id


##}