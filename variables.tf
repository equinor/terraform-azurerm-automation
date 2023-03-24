variable "account_name" {
  description = "The name of this Automation account."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group to create the resources in."
  type        = string
}

variable "location" {
  description = "The location to create the resources in."
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace to send diagnostics to."
  type        = string
}

variable "sku_name" {
  description = "The SKU name of this Automation account."
  type        = string
  default     = "Basic"
}

variable "local_authentication_enabled" {
  description = "Should local authentication be enabled for this Automation account?"
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Should public network access be enabled for this Automation account?"
  type        = bool
  default     = true
}

variable "identity" {
  description = "The identity or identities to configure for this Automation account."

  type = object({
    type         = optional(string, "SystemAssigned")
    identity_ids = optional(list(string), [])
  })

  default = null
}

variable "runbooks" {
  description = "A map of runbooks to create for this Automation account."

  type = map(object({
    name         = string
    description  = optional(string, "")
    runbook_type = optional(string, "PowerShell")
    content      = string
    log_verbose  = optional(bool, false)
    log_progress = optional(bool, false)

    schedule_name        = string
    schedule_description = optional(string, "")
    schedule_frequency   = string
    schedule_interval    = optional(string)
    schedule_start_time  = optional(string)
    schedule_timezone    = optional(string)
    schedule_week_days   = optional(list(string))
    schedule_month_days  = optional(list(number))

    parameters = optional(map(string), {})
  }))

  default = {}
}

variable "diagnostic_setting_name" {
  description = "The name of this diagnostic setting."
  type        = string
  default     = "audit-logs"
}

variable "diagnostic_setting_enabled_log_categories" {
  description = "A list of log categories to be enabled for this diagnostic setting."
  type        = list(string)
  default     = ["AuditEvent"]
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
