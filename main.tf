resource "azurerm_automation_account" "this" {
  name                = var.account_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = var.sku_name

  local_authentication_enabled  = var.local_authentication_enabled
  public_network_access_enabled = var.public_network_access_enabled

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []

    content {
      type         = identity.value["type"]
      identity_ids = identity.value["identity_ids"]
    }
  }
}

resource "time_offset" "this" {
  offset_days = 1

  # TODO: add triggers to update time offset.
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

  # By default, start schedule the next day at 03:00 UTC.
  start_time = coalesce(each.value["start_time"], formatdate("YYYY-MM-DD'T'03:00:00Z", time_offset.this.rfc3339))
  timezone   = coalesce(each.value["timezone"], "Etc/UTC")
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
