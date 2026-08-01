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
      name = "Allow-App-To-Database"

      priority = 100

      direction = "Inbound"

      access = "Allow"

      protocol = "Tcp"

      source_port_range = "*"

      destination_port_range = "5432"

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