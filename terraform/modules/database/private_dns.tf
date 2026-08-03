resource "azurerm_private_dns_zone" "sql" {


  name = "privatelink.database.windows.net"


  resource_group_name = var.resource_group_name


  tags = {

    Application = "ContosoBanking"

    Environment = var.environment

    ManagedBy = "Terraform"

  }

}

resource "azurerm_private_dns_zone_virtual_network_link" "sql" {


  name = "sql-dns-link"


  resource_group_name = var.resource_group_name


  private_dns_zone_name = azurerm_private_dns_zone.sql.name


  virtual_network_id = var.virtual_network_id


}