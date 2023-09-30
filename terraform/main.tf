provider "azurerm" {
  features {}
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}

module "resource_group" {
  source   = "./modules/resource_group"
  name     = "sre-demo-rg"
  location = "UK South"
}

module "vnet_and_subnet" {
  source                  = "./modules/vnet_and_subnet"
  vnet_name               = "sre-demo-vnet"
  subnet_name             = "sre-demo-subnet"
  address_space           = ["10.0.0.0/16"]
  subnet_address_prefixes = ["10.0.1.0/24"]
  resource_group_name     = module.resource_group.rg_name
  location                = module.resource_group.location
}

module "vmss" {
  source              = "./modules/vmss"
  vmss_name           = "sre-demo-vmss"
  resource_group_name = module.resource_group.rg_name
  location            = module.resource_group.location

  sku = {
    name     = "Standard_B1ls"
    tier     = "Standard"
    capacity = 1
  }

  os_profile = {
    computer_name_prefix = "demo"
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
  sa_name             = "newdaydemosatesting"
  resource_group_name = module.resource_group.rg_name
  location            = module.resource_group.location
}

module "autoscale_setting" {
  source              = "./modules/autoscale_setting"
  autoscale_name      = "sre-demo-autoscale"
  resource_group_name = module.resource_group.rg_name
  location            = module.resource_group.location
  target_resource_id  = module.vmss.vmss_id
  metric_resource_id  = module.vmss.vmss_id
}

module "lb_and_pip" {
  source                = "./modules/lb_and_pip"
  pip_name              = "sre-demo-lb-pip"
  lb_name               = "sre-demo-lb"
  frontend_config_name  = "sre-demo-lb-frontend-config"
  backend_pool_name     = "sre-demo-lb-backend-pool"
  probe_name            = "sre-demo-lb-health-probe"
  rule_name             = "sre-demo-lb-rule"
  resource_group_name   = module.resource_group.rg_name
  location              = module.resource_group.location
  diagnostic_storage_id = module.storage_account.storage_account_id
  dependencies          = [module.storage_account]
}

module "nsg" {
  source              = "./modules/nsg"
  nsg_name            = "sre-demo-nsg"
  resource_group_name = module.resource_group.rg_name
  location            = module.resource_group.location
  security_rule_name  = "AllowHTTP"
  subnet_id           = module.vnet_and_subnet.subnet_id
}

module "vmss_extension" {
  source             = "./modules/vmss_extension"
  extension_name     = "ansibleSetup"
  vmss_id            = module.vmss.vmss_id
  script_url         = "https://raw.githubusercontent.com/amirpooyan-haghighat/DemoSRE/main/ansible/setup.sh"
  command_to_execute = "bash setup.sh"
}
