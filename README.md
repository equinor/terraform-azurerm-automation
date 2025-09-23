# Terraform module for Azure Automation

[![GitHub Release](https://img.shields.io/github/v/release/equinor/terraform-azurerm-automation)](https://github.com/equinor/terraform-azurerm-automation/releases/latest)
[![Terraform Module Downloads](https://img.shields.io/terraform/module/dt/equinor/automation/azurerm)](https://registry.terraform.io/modules/equinor/automation/azurerm/latest)
[![GitHub contributors](https://img.shields.io/github/contributors/equinor/terraform-azurerm-automation)](https://github.com/equinor/terraform-azurerm-automation/graphs/contributors)
[![GitHub Issues](https://img.shields.io/github/issues/equinor/terraform-azurerm-automation)](https://github.com/equinor/terraform-azurerm-automation/issues)
[![GitHub Pull requests](https://img.shields.io/github/issues-pr/equinor/terraform-azurerm-automation)](https://github.com/equinor/terraform-azurerm-automation/pulls)
[![GitHub License](https://img.shields.io/github/license/equinor/terraform-azurerm-automation)](https://github.com/equinor/terraform-azurerm-automation/blob/main/LICENSE)

Terraform module which creates Azure Automation resources.

## Features

- Basic tier Automation account created in given resource group by default.
- Microsoft Entra authentication enforced by default.
- Audit logs sent to given Log Analytics workspace by default.

## Prerequisites

- Azure role `Contributor` at the resource group scope.
- Azure role `Log Analytics Contributor` at the Log Analytics workspace scope.

## Usage

```terraform
provider "azurerm" {
  features {}
}

module "automation" {
  source  = "equinor/automation/azurerm"
  version = "~> 4.1"

  account_name               = "example-automation"
  resource_group_name        = azurerm_resource_group.example.name
  location                   = azurerm_resource_group.example.location
  log_analytics_workspace_id = module.log_analytics.workspace_id
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "westeurope"
}

module "log_analytics" {
  source  = "equinor/log-analytics/azurerm"
  version = "~> 2.3"

  workspace_name      = "example-workspace"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
}
```

## Contributing

See [Contributing guidelines](https://github.com/equinor/terraform-baseline/blob/main/CONTRIBUTING.md).
