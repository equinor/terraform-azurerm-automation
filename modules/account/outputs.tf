output "name" {
  description = "The name of this Automation account."
  value       = azurerm_automation_account.this.name
}

output "id" {
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

output "schedule_ids" {
  description = "A map of schedule IDs for this Automation account."

  value = {
    for k, v in azurerm_automation_schedule.this : k => v.id
  }
}
