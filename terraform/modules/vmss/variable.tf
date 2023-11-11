variable "vmss_name" {
  description = "The name of the VM scale set."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region to deploy the VM scale set."
  type        = string
}

variable "sku" {
  description = "The SKU of the VM scale set."
  type        = map(any)
}

variable "os_profile" {
  description = "The OS profile of the VM scale set."
  type        = map(any)
}

variable "network_profile" {
  description = "The network profile of the VM scale set."
  type = object({
    name      = string
    primary   = bool
    subnet_id = string
    ip_configuration = list(object({
      name                                   = string
      primary                                = bool
      subnet_id                              = string
      load_balancer_backend_address_pool_ids = list(string)
    }))
  })
}


variable "boot_diagnostics_enabled" {
  description = "Enables/disables boot diagnostics."
  type        = bool
}

variable "boot_diagnostics_storage_uri" {
  description = "The storage URI for boot diagnostics."
  type        = string
}

variable "dependencies" {
  description = "A list of dependencies for the VM scale set."
  type        = list(any)
  default     = []
}
variable "upgrade_policy_mode" {
  description = "Specifies the mode of an upgrade to virtual machines in the scale set. Possible values are Manual, Automatic, and Rolling."
  default     = "Automatic"
}

variable "os_disk_caching" {
  description = "Specifies the caching requirements for the Operating System Disk. Possible values are None, ReadOnly, and ReadWrite."
  default     = "ReadWrite"
}

variable "os_disk_create_option" {
  description = "Specifies how the OS disk should be created or attached to the virtual machine. Possible values are Attach, FromImage, and Empty."
  default     = "FromImage"
}

variable "os_disk_managed_disk_type" {
  description = "Specifies the type of managed disk to create. Possible values are Standard_LRS, StandardSSD_LRS, or Premium_LRS."
  default     = "Standard_LRS"
}

variable "image_reference" {
  description = "A map defining the image reference for the virtual machines in the scale set."
  default = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18_04-lts-gen2"
    version   = "latest"
  }
}

