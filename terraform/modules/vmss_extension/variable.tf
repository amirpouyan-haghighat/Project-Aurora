variable "extension_name" {
  description = "The name of the VM scale set extension."
  type        = string
}

variable "vmss_id" {
  description = "The ID of the VM scale set."
  type        = string
}

variable "script_url" {
  description = "The URL of the script to run."
  type        = string
}

variable "command_to_execute" {
  description = "The command to execute the script."
  type        = string
}
variable "extension_publisher" {
  description = "The publisher of the VM scale set extension."
  default     = "Microsoft.Azure.Extensions"
}

variable "extension_type" {
  description = "The type of the VM scale set extension."
  default     = "CustomScript"
}

variable "extension_version" {
  description = "The type handler version (major.minor) of the VM scale set extension."
  default     = "2.0"
}

variable "branch_name" {
  description = "The name of the branch to set as an environment variable on the VM"
  type        = string
}
