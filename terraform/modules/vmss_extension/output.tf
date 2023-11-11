output "extension_name" {
  description = "The name of the VMSS Extension."
  value       = azurerm_virtual_machine_scale_set_extension.Project-Aurora_vmss_ansible.name
}
