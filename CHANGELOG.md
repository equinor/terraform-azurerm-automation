# Changelog

## [3.0.0](https://github.com/equinor/terraform-azurerm-automation/compare/v2.0.0...v3.0.0) (2023-11-21)


### ⚠ BREAKING CHANGES

* remove `runbook` submodule ([#16](https://github.com/equinor/terraform-azurerm-automation/issues/16))
* remove schedules
* remove `azurerm_automation_schedule` resources ([#15](https://github.com/equinor/terraform-azurerm-automation/issues/15))

### Features

* remove `azurerm_automation_schedule` resources ([#15](https://github.com/equinor/terraform-azurerm-automation/issues/15)) ([3dbc846](https://github.com/equinor/terraform-azurerm-automation/commit/3dbc846633617f919c1351a4765ff97128cef6cf))
* remove `runbook` submodule ([#16](https://github.com/equinor/terraform-azurerm-automation/issues/16)) ([7437eb1](https://github.com/equinor/terraform-azurerm-automation/commit/7437eb175b2ca025aead9bbbca5e457ea45dbbc2))
* remove schedules ([3dbc846](https://github.com/equinor/terraform-azurerm-automation/commit/3dbc846633617f919c1351a4765ff97128cef6cf))


### Bug Fixes

* get `identity_*` outputs from data source ([#17](https://github.com/equinor/terraform-azurerm-automation/issues/17)) ([7800617](https://github.com/equinor/terraform-azurerm-automation/commit/7800617a617eb9dd579009695f6ae1f6225931b9)), closes [#11](https://github.com/equinor/terraform-azurerm-automation/issues/11)

## [2.0.0](https://github.com/equinor/terraform-azurerm-automation/compare/v1.0.0...v2.0.0) (2023-08-31)


### ⚠ BREAKING CHANGES

* remove variable `identity`, add variables `system_assigned_identity_enabled` and `identity_ids`.

### Code Refactoring

* simplify identity configuration ([#7](https://github.com/equinor/terraform-azurerm-automation/issues/7)) ([9906ce0](https://github.com/equinor/terraform-azurerm-automation/commit/9906ce0919d7a7b192d82ff3db31d3cded5397ba))

## 0.1.0 (2023-03-24)


### Features

* create Automation resources ([#1](https://github.com/equinor/terraform-azurerm-automation/issues/1)) ([591ebdc](https://github.com/equinor/terraform-azurerm-automation/commit/591ebdca7a0f09276cd7a1e8c6a68835ef3ca028))
