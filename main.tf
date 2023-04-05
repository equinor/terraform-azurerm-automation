locals {
  hybrid_runbook_workers = merge([
    for worker_group_key, worker_group_value in var.hybrid_runbook_worker_groups : {
      for worker_key, worker_value in worker_group_value["hybrid_runbook_workers"] : "${worker_group_key}_${worker_key}" => {
        worker_group_name = worker_group_value["name"]
        vm_resource_id    = worker_value["vm_resource_id"]
      } if length(keys(worker_group_value["hybrid_runbook_workers"])) > 0
    }
  ]...)
}

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

resource "azurerm_automation_hybrid_runbook_worker_group" "this" {
  for_each = var.hybrid_runbook_worker_groups

  name                    = each.value["name"]
  automation_account_name = azurerm_automation_account.this.name
  resource_group_name     = azurerm_automation_account.this.resource_group_name
}

resource "random_uuid" "this" {
  for_each = local.hybrid_runbook_workers
}

resource "azurerm_automation_hybrid_runbook_worker" "this" {
  for_each = local.hybrid_runbook_workers

  worker_id               = random_uuid.this[each.key].result
  automation_account_name = azurerm_automation_account.this.name
  resource_group_name     = azurerm_automation_account.this.resource_group_name
  worker_group_name       = each.value["worker_group_name"]
  vm_resource_id          = each.value["vm_resource_id"]
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
