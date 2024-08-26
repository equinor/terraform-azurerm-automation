# Changelog

## [4.1.1](https://github.com/equinor/terraform-azurerm-automation/compare/v4.1.0...v4.1.1) (2024-08-26)


### Miscellaneous Chores

* update variable descriptions and add features list ([#53](https://github.com/equinor/terraform-azurerm-automation/issues/53)) ([9ece204](https://github.com/equinor/terraform-azurerm-automation/commit/9ece204f122b9a4550ce649827dc5e72f8051c4a))

## [4.1.0](https://github.com/equinor/terraform-azurerm-automation/compare/v4.0.2...v4.1.0) (2024-02-27)


### Features

* disable metrics by default ([#46](https://github.com/equinor/terraform-azurerm-automation/issues/46)) ([5c4c5fd](https://github.com/equinor/terraform-azurerm-automation/commit/5c4c5fdcbf22314c413d24db1b84d7372fbca6d4))

## [4.0.2](https://github.com/equinor/terraform-azurerm-automation/compare/v4.0.1...v4.0.2) (2024-01-19)


### Bug Fixes

* all changes to account trigger replace of dependents ([#40](https://github.com/equinor/terraform-azurerm-automation/issues/40)) ([be9d9e5](https://github.com/equinor/terraform-azurerm-automation/commit/be9d9e52101371c55fea29c81b228d659e864ce3))

## [4.0.1](https://github.com/equinor/terraform-azurerm-automation/compare/v4.0.0...v4.0.1) (2023-12-20)


### Bug Fixes

* remove diagnostic setting retention policies ([#38](https://github.com/equinor/terraform-azurerm-automation/issues/38)) ([786581e](https://github.com/equinor/terraform-azurerm-automation/commit/786581efe0864200941e46eeeea8d556fb677e78))

## [4.0.0](https://github.com/equinor/terraform-azurerm-automation/compare/v3.2.0...v4.0.0) (2023-12-18)


### ⚠ BREAKING CHANGES

* **runbook:** change type of variable `job_schedules` from `map(object)` to `list(object)`.

### Code Refactoring

* **runbook:** change variable `job_schedules` type ([#36](https://github.com/equinor/terraform-azurerm-automation/issues/36)) ([8c8b5aa](https://github.com/equinor/terraform-azurerm-automation/commit/8c8b5aa3d0723e6b24d13c106edb5dd12aef2902))

## [3.2.0](https://github.com/equinor/terraform-azurerm-automation/compare/v3.1.1...v3.2.0) (2023-12-08)


### Features

* create runbook ([#33](https://github.com/equinor/terraform-azurerm-automation/issues/33)) ([419fb9f](https://github.com/equinor/terraform-azurerm-automation/commit/419fb9f95085e8fd8afd98b6fb78d3948ad965d0))

## [3.1.1](https://github.com/equinor/terraform-azurerm-automation/compare/v3.1.0...v3.1.1) (2023-11-27)


### Bug Fixes

* set Automation account tags ([#27](https://github.com/equinor/terraform-azurerm-automation/issues/27)) ([67c3119](https://github.com/equinor/terraform-azurerm-automation/commit/67c31191b617aabe176e0e28d7a143ad9d7e60fb))
* set tags ([67c3119](https://github.com/equinor/terraform-azurerm-automation/commit/67c31191b617aabe176e0e28d7a143ad9d7e60fb))

## [3.1.0](https://github.com/equinor/terraform-azurerm-automation/compare/v3.0.1...v3.1.0) (2023-11-22)


### Features

* enable `JobLogs` and `JobStreams` log categories ([#21](https://github.com/equinor/terraform-azurerm-automation/issues/21)) ([b0e2719](https://github.com/equinor/terraform-azurerm-automation/commit/b0e271991c30a20c86895901530f08db3861e129))

## [3.0.1](https://github.com/equinor/terraform-azurerm-automation/compare/v3.0.0...v3.0.1) (2023-11-22)


### Bug Fixes

* invalid value for `data.azurerm_automation_account.this.name` ([#19](https://github.com/equinor/terraform-azurerm-automation/issues/19)) ([a841dc5](https://github.com/equinor/terraform-azurerm-automation/commit/a841dc5ddcb23e46930d4958dcd8e0e1cb08f379))

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
