data "azurerm_client_config" "current" {}

module "resource_group" {

  source = "../../modules/resource-group"


  name = var.resource_group_name

  location = var.location


  tags = {

    Environment = var.environment

    Application = "ContosoBanking"

    ManagedBy = "Terraform"

    Owner = "DevOpsLab"

    CostCenter = "Learning"

  }
}

module "virtual_network" {
  source = "../../modules/virtual-network"

  name                = "vnet-contoso-dev-eastus-001"
  resource_group_name = module.resource_group.resource_group_name
  location            = var.location

  address_space = var.vnet_address_space


  tags = {
    Environment = var.environment
    Application = "ContosoBanking"
    ManagedBy   = "Terraform"
    Owner       = "DevOpsLab"
    CostCenter  = "Learning"
  }
}

module "web_subnet" {
  source = "../../modules/subnet"

  name                 = "snet-web"
  resource_group_name  = module.resource_group.resource_group_name
  virtual_network_name = module.virtual_network.name

  address_prefixes = ["10.10.1.0/24"]

  default_outbound_access_enabled = true
}

module "app_subnet" {
  source = "../../modules/subnet"

  name                 = "snet-app"
  resource_group_name  = module.resource_group.resource_group_name
  virtual_network_name = module.virtual_network.name

  address_prefixes = ["10.10.2.0/24"]

  default_outbound_access_enabled = false
}

module "data_subnet" {
  source = "../../modules/subnet"

  name                 = "snet-data"
  resource_group_name  = module.resource_group.resource_group_name
  virtual_network_name = module.virtual_network.name

  address_prefixes = ["10.10.3.0/24"]

  default_outbound_access_enabled = false
}
module "private_endpoint_subnet" {

  source = "../../modules/subnet"

  name                 = "snet-private-endpoint"
  resource_group_name  = module.resource_group.resource_group_name
  virtual_network_name = module.virtual_network.name

  address_prefixes = ["10.10.4.0/24"]

  default_outbound_access_enabled = false

  private_endpoint_network_policies = "Disabled"

}
module "management_subnet" {
  source = "../../modules/subnet"

  name                 = "snet-management"
  resource_group_name  = module.resource_group.resource_group_name
  virtual_network_name = module.virtual_network.name

  address_prefixes = ["10.10.10.0/24"]

  default_outbound_access_enabled = false
}

module "app_nsg" {
  source = "../../modules/network-security-group"

  name                = "nsg-app"
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
  security_rules = [
    {
      name = "Allow-Web-To-App"

      priority = 100

      direction = "Inbound"

      access = "Allow"

      protocol = "Tcp"

      source_port_range = "*"

      destination_port_range = "8080"

      source_address_prefix = "10.10.1.0/24"

      destination_address_prefix = "*"
    }
  ]
}
module "data_nsg" {
  source = "../../modules/network-security-group"

  name                = "nsg-data"
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
  security_rules = [
    {
      name = "Allow-App-To-SQL"

      priority = 100

      direction = "Inbound"

      access = "Allow"

      protocol = "Tcp"

      source_port_range = "*"

      destination_port_range = "1433"

      source_address_prefix = "10.10.2.0/24"

      destination_address_prefix = "*"
    }
  ]
}
module "management_nsg" {
  source = "../../modules/network-security-group"

  name                = "nsg-management"
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
module "web_nsg" {
  source = "../../modules/network-security-group"

  name                = "nsg-web"
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
  security_rules = [
    {
      name                       = "Allow-HTTPS"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "Internet"
      destination_address_prefix = "*"
    }
  ]
}

module "web_route_table" {

  source = "../../modules/route-table"


  name = "rt-web"


  location = var.location


  resource_group_name = module.resource_group.resource_group_name


  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

module "app_route_table" {

  source = "../../modules/route-table"


  name = "rt-app"


  location = var.location


  resource_group_name = module.resource_group.resource_group_name


  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

module "web_subnet_association" {

  source = "../../modules/subnet-association"


  subnet_id = module.web_subnet.id


  network_security_group_id = module.web_nsg.id


  route_table_id = module.web_route_table.id
}

module "app_subnet_association" {

  source = "../../modules/subnet-association"


  subnet_id = module.app_subnet.id


  network_security_group_id = module.app_nsg.id


  route_table_id = module.app_route_table.id
}

module "web_nic" {

  source = "../../modules/network-interface"

  name                = "nic-web-01"
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name

  subnet_id = module.web_subnet.id

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Application = "ContosoBanking"
  }
}

module "web_vm" {

  source = "../../modules/virtual-machine"

  name                = "vm-web-01"
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name

  size            = "Standard_DC1ds_v3"
  priority        = "Spot"
  eviction_policy = "Deallocate"
  max_bid_price   = -1
  zone            = "1"

  network_interface_ids = [
    module.web_nic.id
  ]

  admin_username = var.admin_username
  public_key     = var.public_key

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Application = "ContosoBanking"
  }

  custom_data = base64encode(file("../../scripts/cloud-init/web-init.yaml"))
}

module "web_data_disk" {

  source = "../../modules/managed-disk"

  name                = "disk-web-data-01"
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name

  disk_size_gb = 32

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Application = "ContosoBanking"
  }
}

module "web_disk_attachment" {

  source = "../../modules/disk-attachment"

  managed_disk_id = module.web_data_disk.id

  virtual_machine_id = module.web_vm.id

  lun = 0
}

module "web_nic_02" {
  source = "../../modules/network-interface"

  name                = "nic-web-02"
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name

  subnet_id = module.web_subnet.id

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Application = "ContosoBanking"
  }
}

module "web_data_disk_02" {
  source = "../../modules/managed-disk"

  name                = "disk-web-data-02"
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name

  disk_size_gb = 32

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Application = "ContosoBanking"
  }
}

module "web_vm_02" {
  source = "../../modules/virtual-machine"

  name                = "vm-web-02"
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name

  size            = "Standard_DC1ds_v3"
  priority        = "Spot"
  eviction_policy = "Deallocate"
  max_bid_price   = -1
  zone            = "1"

  network_interface_ids = [
    module.web_nic_02.id
  ]

  admin_username = var.admin_username
  public_key     = var.public_key

  custom_data = base64encode(
    file("../../scripts/cloud-init/web-init.yaml")
  )


  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Application = "ContosoBanking"
  }
}

module "web_disk_attachment_02" {
  source = "../../modules/disk-attachment"

  managed_disk_id    = module.web_data_disk_02.id
  virtual_machine_id = module.web_vm_02.id

  lun = 0
}

module "app_nic_01" {
  source = "../../modules/network-interface"

  name                = "nic-app-01"
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name

  subnet_id = module.app_subnet.id

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Tier        = "Application"
    Application = "ContosoBanking"
  }
}

module "app_data_disk_01" {
  source = "../../modules/managed-disk"

  name                = "disk-app-data-01"
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name

  disk_size_gb = 64

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Tier        = "Application"
    Application = "ContosoBanking"
  }
}

module "app_vm_01" {
  source = "../../modules/virtual-machine"

  name                = "vm-app-01"
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name

  size            = "Standard_DC1ds_v3"
  priority        = "Spot"
  eviction_policy = "Deallocate"
  max_bid_price   = -1
  zone            = "1"

  network_interface_ids = [
    module.app_nic_01.id
  ]

  admin_username = var.admin_username
  public_key     = var.public_key

  custom_data = base64encode(
    file("../../scripts/cloud-init/app-init.yaml")
  )


  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Tier        = "Application"
    Application = "ContosoBanking"
  }
}

module "app_disk_attachment_01" {
  source = "../../modules/disk-attachment"

  managed_disk_id    = module.app_data_disk_01.id
  virtual_machine_id = module.app_vm_01.id

  lun = 0
}

module "app_gateway_public_ip" {

  source = "../../modules/public-ip"

  name                = "pip-appgw-dev-001"
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name

  allocation_method = "Static"
  sku               = "Standard"

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Application = "ContosoBanking"
  }
}

module "appgateway_subnet" {

  source = "../../modules/subnet"

  name                 = "snet-appgateway"
  resource_group_name  = module.resource_group.resource_group_name
  virtual_network_name = module.virtual_network.name

  address_prefixes = [
    "10.10.0.0/24"
  ]
}

module "application_gateway" {

  source = "../../modules/application-gateway"

  name                = "agw-contoso-dev-001"
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name

  gateway_subnet_id = module.appgateway_subnet.id
  public_ip_id      = module.app_gateway_public_ip.id

  backend_ip_addresses = [
    module.web_vm.private_ip,
    module.web_vm_02.private_ip
  ]

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Application = "ContosoBanking"
  }
}

module "database" {

  source = "../../modules/database"

  resource_group_name = module.resource_group.resource_group_name
  location            = var.location

  sql_server_name   = "sql-contoso-dev-eastus-001"
  sql_database_name = "contoso-banking-db"

  administrator_login    = var.sql_admin_username
  administrator_password = var.sql_admin_password

  private_endpoint_subnet_id = module.data_subnet.subnet_id
  virtual_network_id         = module.virtual_network.virtual_network_id

  environment = var.environment
}


module "key_vault" {

  source = "../../modules/key-vault"

  resource_group_name = module.resource_group.resource_group_name

  location = var.location

  key_vault_name = "kv-contoso-dev-001"

  tenant_id = data.azurerm_client_config.current.tenant_id

  tags = {
    Environment = "dev"
    Project     = "Contoso Financial Services"
    ManagedBy   = "Terraform"
  }

}

module "key_vault_private_endpoint" {

  source = "../../modules/private-endpoint"


  private_endpoint_name = "pe-kv-contoso-dev-001"


  resource_group_name = module.resource_group.resource_group_name


  location = var.location


  subnet_id = module.private_endpoint_subnet.subnet_id


  private_resource_id = module.key_vault.key_vault_id


  subresource_name = "vault"

  private_dns_zone_ids = [
    module.key_vault_private_dns_zone.id
  ]

  tags = {
    Environment = "dev"
    Project     = "Contoso Financial Services"
    ManagedBy   = "Terraform"
  }

}

module "key_vault_private_dns_zone" {

  source = "../../modules/private-dns-zone"


  name = "privatelink.vaultcore.azure.net"


  resource_group_name = module.resource_group.resource_group_name

  virtual_network_id = module.virtual_network.id
  tags = {
    Environment = "dev"
    Project     = "Contoso Financial Services"
    ManagedBy   = "Terraform"
  }

}