output "sql_server_id" {

  description = "SQL Server resource ID"

  value = azurerm_mssql_server.this.id

}


output "sql_server_fqdn" {

  description = "SQL Server fully qualified domain name"

  value = azurerm_mssql_server.this.fully_qualified_domain_name

}

output "sql_database_id" {

  description = "SQL Database resource ID"

  value = azurerm_mssql_database.this.id

}


output "sql_database_name" {

  description = "SQL Database name"

  value = azurerm_mssql_database.this.name

}

output "private_endpoint_ip" {

  description = "Private endpoint IP address"

  value = azurerm_private_endpoint.sql.private_service_connection[0].private_ip_address

}