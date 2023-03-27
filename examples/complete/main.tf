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

resource "time_offset" "this" {
  offset_days = 1
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
      name        = "daily-schedule"
      description = "An example schedule that runs daily."
      frequency   = "Day"
      start_time  = formatdate("YYYY-MM-DD'T'03:00:00Z", time_offset.this.rfc3339) # Start schedule the next day at 03:00 UTC.
      time_zone   = "Etc/UTC"
    }
  }
}

data "local_file" "example" {
  filename = "${path.module}/Write-Hello.ps1"
}

module "runbook" {
  # source = "github.com/equinor/terraform-azurerm-automation//modules/runbook?ref=v0.0.0"
  source = "../../modules/runbook"

  name                = "Write-Hello"
  account_name        = module.automation.account_name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  content             = data.local_file.example.content
  description         = "An example runbook which writes a greeting to the given name."

  job_schedules = {
    "example" = {
      schedule_name = module.automation.schedule_names["example"]
      parameters    = { "Name" = "John Smith" }
    }
  }
}
