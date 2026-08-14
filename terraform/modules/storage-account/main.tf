resource "azurerm_storage_account" "this" {

  name                = var.storage_account_name
  resource_group_name = var.resource_group_name
  location            = var.location

  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  min_tls_version                 = "TLS1_2"
  https_traffic_only_enabled      = true
  public_network_access_enabled   = false
  allow_nested_items_to_be_public = false


  blob_properties {

    versioning_enabled = true
    delete_retention_policy {

      days = 7

  }

  container_delete_retention_policy {

    days = 7
  }
}
  tags = var.tags
}

