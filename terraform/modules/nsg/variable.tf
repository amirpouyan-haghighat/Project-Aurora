variable "nsg_name" {
  description = "The name of the network security group."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region to deploy the network security group."
  type        = string
}

variable "security_rule_name" {
  description = "The name of the security rule."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet."
  type        = string
}
variable "security_rule_priority" {
  description = "The priority of the security rule."
  default     = 100
}

variable "security_rule_direction" {
  description = "The direction specifies if rule will be evaluated on incoming or outgoing traffic."
  default     = "Inbound"
}

variable "security_rule_access" {
  description = "Specifies whether network traffic is allowed or denied. Possible values are Allow and Deny."
  default     = "Allow"
}

variable "security_rule_protocol" {
  description = "Network protocol this rule applies to. Possible values include Tcp, Udp, Icmp, Esp, Ah, or * (which signifies any protocol)."
  default     = "Tcp"
}

variable "security_rule_source_port_range" {
  description = "The source port or range. Integer or range between 0 and 65535 or * to match any."
  default     = "*"
}

variable "security_rule_destination_port_range" {
  description = "The destination port or range. Integer or range between 0 and 65535 or * to match any."
  default     = "80"
}

variable "security_rule_source_address_prefix" {
  description = "CIDR or source IP range. Asterisk '*' can also be used to match all source IPs. Default tags can also be used."
  default     = "*"
}

variable "security_rule_destination_address_prefix" {
  description = "CIDR or destination IP range, or the asterisk '*' to match all. Default tags can also be used."
  default     = "*"
}

