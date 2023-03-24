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

  job_schedules = {
    "example" = {
      runbook_name         = "example-runbook"
      runbook_description  = "An example runbook which writes a given name to output."
      schedule_name        = "daily-schedule"
      schedule_description = "A schedule which triggers the example runbook once per day."
      content              = data.local_file.example.content
      frequency            = "Day"
      interval             = 1

      parameters = {
        "Name" = "John Smith"
      }
    }
  }
}
