provider "azurerm" {
  features {}
}

resource "random_id" "example" {
  byte_length = 8
}

resource "azurerm_resource_group" "example" {
  name     = "rg-${random_id.example.hex}"
  location = var.location
}

module "log_analytics" {
  source = "github.com/equinor/terraform-azurerm-log-analytics?ref=v1.3.1"

  workspace_name      = "log-${random_id.example.hex}"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
}

data "local_file" "example" {
  filename = "${path.module}/example.ps1"
}

module "automation" {
  # source = "github.com/equinor/terraform-azurerm-automation?ref=v0.0.0"
  source = "../.."

  account_name               = "aa-${random_id.example.hex}"
  resource_group_name        = azurerm_resource_group.example.name
  location                   = azurerm_resource_group.example.location
  log_analytics_workspace_id = module.log_analytics.workspace_id

  schedules = {
    "example" = {
      name       = "daily-schedule"
      frequency  = "Day"
      start_time = "" # todo
      timezone   = "Etc/UTC"
    }
  }

  runbooks = {
    "example" = {
      name         = "example-runbook"
      description  = "An example runbook"
      runbook_type = "PowerShell"
      content      = data.local_file.example.content
      log_verbose  = false
      log_progress = false
    }
  }

  job_schedules = {
    "example" = {
      schedule_name = "daily-schedule"
      runbook_name  = "example-runbook"

      parameters = {
        "Name" = "John Smith"
      }
    }
  }
}
