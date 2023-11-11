variable "pip_name" {
  description = "The name of the public IP."
  type        = string
}

variable "lb_name" {
  description = "The name of the load balancer."
  type        = string
}

variable "frontend_config_name" {
  description = "The name of the frontend configuration."
  type        = string
}

variable "backend_pool_name" {
  description = "The name of the backend pool."
  type        = string
}

variable "probe_name" {
  description = "The name of the health probe."
  type        = string
}

variable "rule_name" {
  description = "The name of the load balancer rule."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region to deploy the load balancer and public IP."
  type        = string
}

variable "dependencies" {
  description = "A list of dependencies for the load balancer and public IP."
  type        = list(any)
  default     = []
}
variable "pip_allocation_method" {
  description = "Defines the allocation method for this IP address. Possible values are Static or Dynamic."
  default     = "Static"
}

variable "lb_sku" {
  description = "The SKU of the load balancer and public IP. Possible values are Basic and Standard."
  default     = "Standard"
}

variable "probe_port" {
  description = "The port for the health probe."
  default     = 80
}

variable "probe_protocol" {
  description = "The protocol for the health probe. Possible values include Http, Https, or Tcp."
  default     = "Http"
}

variable "probe_request_path" {
  description = "The request path for the health probe. Required if protocol is set to Http or Https."
  default     = "/"
}

variable "probe_interval" {
  description = "The interval in seconds between probes to the backend endpoint for health status."
  default     = 15
}

variable "probe_count" {
  description = "The number of times the load balancer will attempt to probe each backend VM in the load balancer."
  default     = 2
}

variable "rule_protocol" {
  description = "The protocol for the load balancer rule. Possible values include Http, Https, Tcp, or Udp."
  default     = "Tcp"
}

variable "rule_frontend_port" {
  description = "The frontend port that will be used for the load balancer rule."
  default     = 80
}

variable "rule_backend_port" {
  description = "The backend port that will be used for the load balancer rule."
  default     = 80
}
