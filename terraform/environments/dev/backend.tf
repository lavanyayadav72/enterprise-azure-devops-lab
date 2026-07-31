terraform {
  backend "azurerm" {
    resource_group_name  = "rg-contoso-tfstate-eastus-001"
    storage_account_name = "stcontosotfstate099"
    container_name       = "tfstate"
    key                  = "dev/terraform.tfstate"
  }
}