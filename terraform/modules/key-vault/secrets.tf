resource "azurerm_key_vault_secret" "app_secret" {

  name = "app-secret"

  value = "Contoso-Demo-Secret-123"

  key_vault_id = azurerm_key_vault.this.id

}