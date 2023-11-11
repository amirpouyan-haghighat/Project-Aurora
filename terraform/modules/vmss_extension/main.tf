resource "azurerm_virtual_machine_scale_set_extension" "Project-Aurora_vmss_ansible" {
  name                         = var.extension_name
  virtual_machine_scale_set_id = var.vmss_id
  publisher                    = var.extension_publisher
  type                         = var.extension_type
  type_handler_version         = var.extension_version

  settings = jsonencode({
    "fileUris" : [var.script_url],
    "commandToExecute" : "export BRANCH_NAME='${var.branch_name}' && ${var.command_to_execute}"
  })
}
