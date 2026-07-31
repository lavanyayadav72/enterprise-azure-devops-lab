resource "azurerm_subnet_network_security_group_association" "this" {

  subnet_id = var.subnet_id

  network_security_group_id = var.network_security_group_id
}


resource "azurerm_subnet_route_table_association" "this" {

  subnet_id = var.subnet_id

  route_table_id = var.route_table_id
}