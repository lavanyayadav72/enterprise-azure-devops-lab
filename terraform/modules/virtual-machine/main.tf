resource "azurerm_linux_virtual_machine" "this" {

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  zone = var.zone

  size = var.size

  priority        = var.priority
  eviction_policy = var.eviction_policy
  max_bid_price   = var.max_bid_price

  admin_username = var.admin_username

  network_interface_ids = var.network_interface_ids

  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  tags = var.tags
  custom_data = var.custom_data

  boot_diagnostics {
  storage_account_uri = null
}
  identity {
    type = "SystemAssigned"
}
  
}