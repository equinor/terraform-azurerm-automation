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

resource "azurerm_automation_runbook" "this" {
  for_each = var.runbooks

  name                    = each.value["name"]
  automation_account_name = azurerm_automation_account.this.name
  resource_group_name     = azurerm_automation_account.this.resource_group_name
  location                = azurerm_automation_account.this.location
  description             = each.value["description"]
  runbook_type            = each.value["runbook_type"]
  content                 = each.value["content"]
  log_verbose             = each.value["log_verbose"]
  log_progress            = each.value["log_progress"]

  tags = var.tags
}

resource "time_offset" "this" {
  offset_days = 1

  # TODO: add triggers to update time offset.
}

resource "azurerm_automation_schedule" "this" {
  for_each = var.runbooks

  name                    = each.value["schedule_name"]
  automation_account_name = azurerm_automation_account.this.name
  resource_group_name     = azurerm_automation_account.this.resource_group_name
  description             = each.value["schedule_description"]

  frequency = each.value["schedule_frequency"]
  interval  = each.value["schedule_interval"]

  # By default, start schedule the next day at 03:00 UTC.
  start_time = coalesce(each.value["schedule_start_time"], formatdate("YYYY-MM-DD'T'03:00:00Z", time_offset.this.rfc3339))
  timezone   = coalesce(each.value["schedule_timezone"], "Etc/UTC")

  week_days  = each.value["schedule_week_days"]
  month_days = each.value["schedule_month_days"]
}

resource "azurerm_automation_job_schedule" "this" {
  for_each = var.runbooks

  automation_account_name = azurerm_automation_account.this.name
  resource_group_name     = azurerm_automation_account.this.resource_group_name
  runbook_name            = azurerm_automation_runbook.this[each.key].name
  schedule_name           = azurerm_automation_schedule.this[each.key].name

  # The parameter keys/names must strictly be in lowercase, even if this is not the case in the runbook.
  # This is due to a limitation in Azure Automation where the parameter names are normalized.
  # The values specified don't have this limitation.
  parameters = {
    for k, v in each.value["parameters"] : lower(k) => v
  }
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
