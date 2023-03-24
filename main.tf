module "account" {
  source = "./modules/account"

  name                                      = var.account_name
  resource_group_name                       = var.resource_group_name
  location                                  = var.location
  sku_name                                  = var.sku_name
  local_authentication_enabled              = var.local_authentication_enabled
  public_network_access_enabled             = var.public_network_access_enabled
  identity                                  = var.identity
  schedules                                 = var.schedules
  log_analytics_workspace_id                = var.log_analytics_workspace_id
  diagnostic_setting_name                   = var.diagnostic_setting_name
  diagnostic_setting_enabled_log_categories = var.diagnostic_setting_enabled_log_categories

  tags = var.tags
}

# module "runbook" {
#   source = "./modules/runbook"
# }
