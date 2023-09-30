resource "azurerm_virtual_machine_scale_set" "sre_demo_vmss" {
  name                = var.vmss_name
  location            = var.location
  resource_group_name = var.resource_group_name
  upgrade_policy_mode = var.upgrade_policy_mode

  sku {
    name     = var.sku.name
    tier     = var.sku.tier
    capacity = 2
  }

  os_profile {
    computer_name_prefix = var.os_profile.computer_name_prefix
    admin_username       = var.os_profile.admin_username
    admin_password       = var.os_profile.admin_password
  }

  network_profile {
    name    = var.network_profile.name
    primary = var.network_profile.primary

    ip_configuration {
      name                                   = var.network_profile.ip_configuration[0].name
      primary                                = var.network_profile.ip_configuration[0].primary
      subnet_id                              = var.network_profile.ip_configuration[0].subnet_id
      load_balancer_backend_address_pool_ids = var.network_profile.ip_configuration[0].load_balancer_backend_address_pool_ids
    }
  }

  storage_profile_os_disk {
    caching           = var.os_disk_caching
    create_option     = var.os_disk_create_option
    managed_disk_type = var.os_disk_managed_disk_type
  }

  storage_profile_image_reference {
    publisher = var.image_reference.publisher
    offer     = var.image_reference.offer
    sku       = var.image_reference.sku
    version   = var.image_reference.version
  }

  boot_diagnostics {
    enabled     = var.boot_diagnostics_enabled
    storage_uri = var.boot_diagnostics_storage_uri
  }
  depends_on = [var.dependencies]
}
