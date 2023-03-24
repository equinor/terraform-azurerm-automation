resource "azurerm_automation_runbook" "this" {
  name                    = var.name
  automation_account_name = var.account_name
  resource_group_name     = var.resource_group_name
  location                = var.location
  description             = var.description
  runbook_type            = var.runbook_type
  content                 = var.content
  log_verbose             = var.log_verbose
  log_progress            = var.log_progress

  tags = var.tags
}

resource "azurerm_automation_job_schedule" "this" {
  for_each = var.job_schedules

  automation_account_name = var.account_name
  resource_group_name     = var.resource_group_name
  runbook_name            = azurerm_automation_runbook.this.name
  schedule_name           = each.value["schedule_name"]

  # The parameter keys/names must strictly be in lowercase, even if this is not the case in the runbook.
  # This is due to a limitation in Azure Automation where the parameter names are normalized.
  # The values specified don't have this limitation.
  parameters = {
    for k, v in each.value["parameters"] : lower(k) => v
  }
}
