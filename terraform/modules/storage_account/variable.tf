variable "sa_name" {
  description = "The name of the storage account."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region to deploy the storage account."
  type        = string
}
variable "account_tier" {
  description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium."
  default     = "Standard"
}

variable "account_replication_type" {
  description = "The type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS, and RAGZRS."
  default     = "LRS"
}
