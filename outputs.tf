output "account_name" {
  description = "The name of this Automation account."
  value       = azurerm_automation_account.this.name
}

output "account_id" {
  description = "The ID of this Automation account."
  value       = azurerm_automation_account.this.id
}

output "identity_principal_id" {
  description = "The principal ID of the system-assigned identity of this Automation account. This value will be null if the system-assigned identity is disabled."
  value       = try(azurerm_automation_account.this.identity[0].principal_id, null)
}

output "identity_tenant_id" {
  description = "The tenant ID of the system-assigned identity of this Automation account. This value will be null if the system-assigned identity is disabled."
  value       = try(azurerm_automation_account.this.identity[0].tenant_id, null)
}
