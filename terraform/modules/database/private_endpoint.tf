resource "azurerm_private_endpoint" "sql" {


  name = "pe-sql-contoso-dev-001"


  location = var.location


  resource_group_name = var.resource_group_name


  subnet_id = var.private_endpoint_subnet_id



  private_service_connection {


    name = "sql-private-connection"


    private_connection_resource_id = azurerm_mssql_server.this.id


    subresource_names = [
      "sqlServer"
    ]


    is_manual_connection = false

  }

  private_dns_zone_group {
    name                 = "sql-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.sql.id]
  }

  tags = {
    Application = "ContosoBanking"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}