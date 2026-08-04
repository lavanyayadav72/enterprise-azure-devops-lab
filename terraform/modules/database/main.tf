resource "azurerm_mssql_server" "this" {

  name                = var.sql_server_name
  resource_group_name = var.resource_group_name
  location            = var.location

  version = "12.0"

  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_password

  public_network_access_enabled = false


  tags = {
    Application = "ContosoBanking"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "azurerm_mssql_database" "this" {


  name = var.sql_database_name


  server_id = azurerm_mssql_server.this.id


  sku_name = var.sql_database_sku


  max_size_gb = 2


  storage_account_type = "Local"


  tags = {

    Application = "ContosoBanking"

    Environment = var.environment

    ManagedBy = "Terraform"

  }

}