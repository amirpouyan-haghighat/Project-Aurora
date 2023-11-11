variable "autoscale_name" {
  description = "The name of the autoscale setting."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The location/region where the autoscale setting is created."
  type        = string
}

variable "target_resource_id" {
  description = "The ID of the resource that the autoscale setting should target."
  type        = string
}

variable "profile_name" {
  description = "The name of the profile for the autoscale setting."
  type        = string
  default     = "CPU Autoscale Profile"
}

variable "capacity_default" {
  description = "The default number of instances for the autoscale setting."
  type        = number
  default     = 2
}

variable "capacity_minimum" {
  description = "The minimum number of instances for the autoscale setting."
  type        = number
  default     = 1
}

variable "capacity_maximum" {
  description = "The maximum number of instances for the autoscale setting."
  type        = number
  default     = 4
}

variable "metric_name" {
  description = "The name of the metric used for the autoscale setting."
  type        = string
  default     = "Percentage CPU"
}

variable "metric_resource_id" {
  description = "The resource ID for the metric used in the autoscale setting."
  type        = string
}

variable "time_grain" {
  description = "The granularity of metrics in the time."
  type        = string
  default     = "PT1M"
}

variable "statistic" {
  description = "The metric statistic or aggregation type."
  type        = string
  default     = "Average"
}

variable "time_window" {
  description = "The amount of time (in minutes) that is used to monitor for the metric."
  type        = string
  default     = "PT5M"
}

variable "time_aggregation" {
  description = "The aggregation type for the metric (Average, Count, Total, Minimum, Maximum)."
  type        = string
  default     = "Average"
}

variable "operator" {
  description = "The operator for the metric trigger."
  type        = string
  default     = "GreaterThan"
}

variable "threshold" {
  description = "The threshold that activates the scale action."
  type        = number
  default     = 75
}

variable "scale_action_direction" {
  description = "The scale direction. Can be 'Increase' or 'Decrease'."
  type        = string
  default     = "Increase"
}

variable "scale_action_type" {
  description = "The type of action that should occur when the scale rule fires."
  type        = string
  default     = "ChangeCount"
}

variable "scale_action_value" {
  description = "The value for the scale action to perform."
  type        = string
  default     = "1"
}

variable "scale_action_cooldown" {
  description = "The amount of time to wait since the last scale action before scaling again."
  type        = string
  default     = "PT10M"
}
