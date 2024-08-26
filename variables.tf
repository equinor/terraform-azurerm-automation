variable "account_name" {
  description = "The name of this Automation account."
  type        = string
  nullable    = false
}

variable "resource_group_name" {
  description = "The name of the resource group to create the resources in."
  type        = string
  nullable    = false
}

variable "location" {
  description = "The location to create the resources in."
  type        = string
  nullable    = false
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace to send diagnostics to."
  type        = string
  nullable    = false
}

variable "sku_name" {
  description = "The SKU name of this Automation account. Value must be \"Basic\" or \"Free\"."
  type        = string
  default     = "Basic"
  nullable    = false

  validation {
    condition     = contains(["Basic", "Free"], var.sku_name)
    error_message = "SKU name must be \"Basic\" or \"Free\"."
  }
}

variable "local_authentication_enabled" {
  description = "Should local authentication be enabled for this Automation account?"
  type        = bool
  default     = false
  nullable    = false
}

variable "public_network_access_enabled" {
  description = "Should public network access be enabled for this Automation account?"
  type        = bool
  default     = true
  nullable    = false
}

variable "system_assigned_identity_enabled" {
  description = "Should the system-assigned identity be enabled for this Automation account?"
  type        = bool
  default     = false
  nullable    = false
}

variable "identity_ids" {
  description = "A list of IDs of managed identities to be assigned to this Automation account."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "diagnostic_setting_name" {
  description = "The name of this diagnostic setting."
  type        = string
  default     = "audit-logs"
  nullable    = false
}

variable "diagnostic_setting_enabled_log_categories" {
  description = "A list of log categories to be enabled for this diagnostic setting."
  type        = list(string)
  default     = ["AuditEvent", "JobLogs", "JobStreams"]
  nullable    = false
}

variable "diagnostic_setting_enabled_metric_categories" {
  description = "A list of metric categories to be enabled for this diagnostic setting."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
  nullable    = false
}
