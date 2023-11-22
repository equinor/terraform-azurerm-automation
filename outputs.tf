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

  # Get "principal_id" from a data source to read its value during the the apply phase instead of the plan phase.
  # This ensures the Automation account system-assigned identity is always enabled before trying to read its principal ID.
  # Ref: https://developer.hashicorp.com/terraform/language/data-sources#data-resource-behavior
  value = try(data.azurerm_automation_account.this.identity[0].principal_id, null)
}

output "identity_tenant_id" {
  description = "The tenant ID of the system-assigned identity of this Automation account."

  # Get "tenant_id" from a data source to read its value during the the apply phase instead of the plan phase.
  # This ensures the Automation account system-assigned identity is always enabled before trying to read its tenant ID.
  # Ref: https://developer.hashicorp.com/terraform/language/data-sources#data-resource-behavior
  value = try(data.azurerm_automation_account.this.identity[0].tenant_id, null)
}
