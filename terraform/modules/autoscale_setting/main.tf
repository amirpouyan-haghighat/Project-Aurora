resource "azurerm_monitor_autoscale_setting" "sre_demo_as" {
  name                = var.autoscale_name
  resource_group_name = var.resource_group_name
  location            = var.location
  target_resource_id  = var.target_resource_id

  profile {
    name = var.profile_name

    capacity {
      default = var.capacity_default
      minimum = var.capacity_minimum
      maximum = var.capacity_maximum
    }

    rule {
      metric_trigger {
        metric_name        = var.metric_name
        metric_resource_id = var.metric_resource_id
        time_grain         = var.time_grain
        statistic          = var.statistic
        time_window        = var.time_window
        time_aggregation   = var.time_aggregation
        operator           = var.operator
        threshold          = var.threshold
      }

      scale_action {
        direction = var.scale_action_direction
        type      = var.scale_action_type
        value     = var.scale_action_value
        cooldown  = var.scale_action_cooldown
      }
    }
  }
}
