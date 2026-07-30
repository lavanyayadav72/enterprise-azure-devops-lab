resource "azurerm_resource_group" "tfstate" {

  name = "rg-contoso-tfstate-eastus-001"

  location = "East US"

  tags = {
    Environment = "bootstrap"
    Application = "TerraformState"
    ManagedBy   = "Terraform"
    Owner       = "DevOpsLab"
    CostCenter  = "Learning"
  }
}


resource "azurerm_storage_account" "tfstate" {

  name = "stcontosotfstate099"

  resource_group_name = azurerm_resource_group.tfstate.name

  location = azurerm_resource_group.tfstate.location


  account_tier = "Standard"

  account_replication_type = "LRS"


  min_tls_version = "TLS1_2"


  tags = {
    Environment = "bootstrap"
    ManagedBy   = "Terraform"
  }
}


resource "azurerm_storage_container" "tfstate" {

  name = "tfstate"

  storage_account_name = azurerm_storage_account.tfstate.name

  container_access_type = "private"
}