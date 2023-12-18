resource "azurerm_automation_runbook" "this" {
  name                    = var.runbook_name
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
  count = length(var.job_schedules)

  automation_account_name = var.account_name
  resource_group_name     = var.resource_group_name
  runbook_name            = azurerm_automation_runbook.this.name
  schedule_name           = var.job_schedules[count.index].schedule_name

  # The parameter keys/names must strictly be in lowercase, even if this is not the case in the runbook.
  # This is due to a limitation in Azure Automation where the parameter names are normalized.
  # The values specified don't have this limitation.
  parameters = {
    for k, v in var.job_schedules[count.index].parameters : lower(k) => v
  }

  lifecycle {
    replace_triggered_by = [
      # Any changes to this runbook will unlink it from all schedules, i.e. delete this job schedule resource.
      # Trigger a replace on all changes to this runbook to ensure the job schedule is always recreated in this scenario.
      azurerm_automation_runbook.this
    ]
  }
}
