output "account_name" {
  description = "The name of this Automation account."
  value       = azurerm_automation_account.this.name
}

output "account_id" {
  description = "The ID of this Automation account."
  value       = azurerm_automation_account.this.id
}

output "identity_principal_id" {
  description = "The principal ID of the system-assigned identity of this Automation account."
  value       = try(azurerm_automation_account.this.identity[0].principal_id, null)
}

output "identity_tenant_id" {
  description = "The tenant ID of the system-assigned identity of this Automation account."
  value       = try(azurerm_automation_account.this.identity[0].tenant_id, null)
}

output "hybrid_runbook_worker_ids" {
  description = "A map of hybrid runbook worker IDs for this Automation account."

  value = {
    for k, v in azurerm_automation_hybrid_runbook_worker.this : k => v.id
  }
}

output "hybrid_runbook_worker_ips" {
  description = "A map of hybrid runbook worker IPs for this Automation account."

  value = {
    for k, v in azurerm_automation_hybrid_runbook_worker.this : k => v.ip
  }
}

output "hybrid_runbook_worker_names" {
  description = "A map of hybrid runbook worker names for this Automation account."

  value = {
    for k, v in azurerm_automation_hybrid_runbook_worker.this : k => v.worker_name
  }
}

output "hybrid_runbook_worker_types" {
  description = "A map of hybrid runbook worker types for this Automation account."

  value = {
    for k, v in azurerm_automation_hybrid_runbook_worker.this : k => v.worker_type
  }
}

output "schedule_ids" {
  description = "A map of schedule IDs for this Automation account."

  value = {
    for k, v in azurerm_automation_schedule.this : k => v.id
  }
}

output "schedule_names" {
  description = "A map of schedule names for this Automation account."

  value = {
    for k, v in azurerm_automation_schedule.this : k => v.name
  }
}
