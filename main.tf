locals {
  # If system_assigned_identity_enabled is true, value is "SystemAssigned".
  # If identity_ids is non-empty, value is "UserAssigned".
  # If system_assigned_identity_enabled is true and identity_ids is non-empty, value is "SystemAssigned, UserAssigned".
  identity_type = join(", ", compact([var.system_assigned_identity_enabled ? "SystemAssigned" : "", length(var.identity_ids) > 0 ? "UserAssigned" : ""]))
}

resource "azurerm_automation_account" "this" {
  name                = var.account_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = var.sku_name

  local_authentication_enabled  = var.local_authentication_enabled
  public_network_access_enabled = var.public_network_access_enabled

  dynamic "identity" {
    for_each = local.identity_type != "" ? [1] : []

    content {
      type         = local.identity_type
      identity_ids = var.identity_ids
    }
  }
}

resource "azurerm_automation_schedule" "this" {
  for_each = var.schedules

  name                    = each.value["name"]
  automation_account_name = azurerm_automation_account.this.name
  resource_group_name     = azurerm_automation_account.this.resource_group_name
  description             = each.value["description"]

  frequency  = each.value["frequency"]
  interval   = each.value["interval"]
  week_days  = each.value["week_days"]
  month_days = each.value["month_days"]

  start_time = each.value["start_time"]
  timezone   = each.value["timezone"]
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  name                       = var.diagnostic_setting_name
  target_resource_id         = azurerm_automation_account.this.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  dynamic "enabled_log" {
    for_each = toset(var.diagnostic_setting_enabled_log_categories)

    content {
      category = enabled_log.value
    }
  }

  metric {
    category = "AllMetrics"
    enabled  = false

    retention_policy {
      days    = 0
      enabled = false
    }
  }
}
