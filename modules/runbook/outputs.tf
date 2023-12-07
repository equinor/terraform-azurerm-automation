output "runbook_name" {
  description = "The name of this Automation runbook."
  value       = azurerm_automation_runbook.this.name
}

output "runbook_id" {
  description = "The ID of this Automation runbook."
  value       = azurerm_automation_runbook.this.id
}

output "job_schedule_ids" {
  description = "A map of job schedule IDs for this Automation runbook."

  value = {
    for k, v in azurerm_automation_job_schedule.this : k => v.id
  }
}
