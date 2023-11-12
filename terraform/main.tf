provider "azurerm" {
  features {}
}
provider "random" {
  version = "~> 3.0"
}

resource "random_string" "sa_suffix" {
  length  = 8
  upper   = false
  lower   = true
  number  = true
  special = false
}

module "resource_group" {
  source   = "./modules/resource_group"
  name     = "Project-Aurora-rg"
  location = "UK South"
}

module "vnet_and_subnet" {
  source                  = "./modules/vnet_and_subnet"
  vnet_name               = "Project-Aurora-vnet"
  subnet_name             = "Project-Aurora-subnet"
  address_space           = ["10.0.0.0/16"]
  subnet_address_prefixes = ["10.0.1.0/24"]
  resource_group_name     = module.resource_group.rg_name
  location                = module.resource_group.location
}

# using standard sku
# attaching network profile to load balancer and attach it to same subnet
# enabling boot diangnostics and set it to storage account
module "vmss" {
  source              = "./modules/vmss"
  vmss_name           = "Project-Aurora-vmss"
  resource_group_name = module.resource_group.rg_name
  location            = module.resource_group.location

  sku = {
    name     = "Standard_B1ls"
    tier     = "Standard"
    capacity = 1
  }

  os_profile = {
    computer_name_prefix = "Aurora"
    admin_username       = "adminuser"
    admin_password       = "Password123!"
  }

  network_profile = {
    name      = "default"
    primary   = true
    subnet_id = module.vnet_and_subnet.subnet_id
    ip_configuration = [
      {
        name                                   = "primary"
        primary                                = true
        subnet_id                              = module.vnet_and_subnet.subnet_id
        load_balancer_backend_address_pool_ids = [module.lb_and_pip.backend_pool_id]
      }
    ]
  }


  boot_diagnostics_enabled     = true
  boot_diagnostics_storage_uri = module.storage_account.primary_blob_endpoint
  dependencies                 = [module.storage_account]
}


module "storage_account" {
  source              = "./modules/storage_account"
  sa_name             = random_string.sa_suffix.result
  resource_group_name = module.resource_group.rg_name
  location            = module.resource_group.location
}

module "autoscale_setting" {
  source              = "./modules/autoscale_setting"
  autoscale_name      = "Project-Aurora-autoscale"
  resource_group_name = module.resource_group.rg_name
  location            = module.resource_group.location
  target_resource_id  = module.vmss.vmss_id
  metric_resource_id  = module.vmss.vmss_id
}

module "lb_and_pip" {
  source               = "./modules/lb_and_pip"
  pip_name             = "Project-Aurora-lb-pip"
  lb_name              = "Project-Aurora-lb"
  frontend_config_name = "Project-Aurora-lb-frontend-config"
  backend_pool_name    = "Project-Aurora-lb-backend-pool"
  probe_name           = "Project-Aurora-lb-health-probe"
  rule_name            = "Project-Aurora-lb-rule"
  resource_group_name  = module.resource_group.rg_name
  location             = module.resource_group.location
  dependencies         = [module.storage_account]
}

module "nsg" {
  source              = "./modules/nsg"
  nsg_name            = "Project-Aurora-nsg"
  resource_group_name = module.resource_group.rg_name
  location            = module.resource_group.location
  security_rule_name  = "AllowHTTP"
  subnet_id           = module.vnet_and_subnet.subnet_id
}

# dynamically use the current github repository
# download the whole project zip file frome the respective branch dynamiclly
# inject the branch name from root variable.tf inside module itself
module "vmss_extension" {
  source             = "./modules/vmss_extension"
  extension_name     = "ansibleSetup"
  vmss_id            = module.vmss.vmss_id
  script_url         = "https://raw.githubusercontent.com/amirpouyan-haghighat/Project-Aurora/${var.branch_name}/ansible/setup.sh"
  command_to_execute = "bash setup.sh"
  branch_name        = var.branch_name
}
