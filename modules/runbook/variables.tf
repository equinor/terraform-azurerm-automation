variable "runbook_name" {
  description = "The name of this Automation runbook."
  type        = string
}

variable "account_name" {
  description = "The name of the Automation account to create this runbook in."
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

variable "content" {
  description = "The content of this Automation runbook."
  type        = string
}

variable "description" {
  description = "A description for this Automation runbook."
  type        = string
  default     = ""
}

variable "runbook_type" {
  description = "The type of Automation runbook to create."
  type        = string
  default     = "PowerShell"
}

variable "log_verbose" {
  description = "Should verbose logs be enabled for this Automation runbook?"
  type        = bool
  default     = false
}

variable "log_progress" {
  description = "Should progress logs be enabled for this Automation runbook?"
  type        = bool
  default     = false
}

variable "job_schedules" {
  description = "A map of job schedules to create for this Automation runbook."

  type = map(object({
    schedule_name = string
    parameters    = optional(map(string), {})
  }))

  default = {}
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
