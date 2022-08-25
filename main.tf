/**
 * # postgresql
 *
 * This module manages Azure PostgreSQL.
 *
*/

resource "azurerm_postgresql_server" "postgresql_server" {
  for_each = var.postgresql_server

  name                              = local.postgresql_server[each.key].name == "" ? each.key : local.postgresql_server[each.key].name
  location                          = local.postgresql_server[each.key].location
  resource_group_name               = local.postgresql_server[each.key].resource_group_name
  sku_name                          = local.postgresql_server[each.key].sku_name
  version                           = local.postgresql_server[each.key].version
  administrator_login               = local.postgresql_server[each.key].administrator_login
  administrator_login_password      = local.postgresql_server[each.key].administrator_login_password
  auto_grow_enabled                 = local.postgresql_server[each.key].auto_grow_enabled
  backup_retention_days             = local.postgresql_server[each.key].backup_retention_days
  create_mode                       = local.postgresql_server[each.key].create_mode
  creation_source_server_id         = local.postgresql_server[each.key].creation_source_server_id
  geo_redundant_backup_enabled      = local.postgresql_server[each.key].geo_redundant_backup_enabled
  infrastructure_encryption_enabled = local.postgresql_server[each.key].infrastructure_encryption_enabled
  public_network_access_enabled     = local.postgresql_server[each.key].public_network_access_enabled
  restore_point_in_time             = local.postgresql_server[each.key].restore_point_in_time
  ssl_enforcement_enabled           = local.postgresql_server[each.key].ssl_enforcement_enabled
  ssl_minimal_tls_version_enforced  = local.postgresql_server[each.key].ssl_minimal_tls_version_enforced
  storage_mb                        = local.postgresql_server[each.key].storage_mb

  dynamic "identity" {
    for_each = local.postgresql_server[each.key].identity != {} ? [1] : []

    content {
      type = local.postgresql_server[each.key].identity.type
    }
  }

  dynamic "threat_detection_policy" {
    for_each = local.postgresql_server[each.key].threat_detection_policy != {} ? [1] : []

    content {
      enabled                    = local.postgresql_server[each.key].threat_detection_policy.enabled
      disabled_alerts            = local.postgresql_server[each.key].threat_detection_policy.disabled_alerts
      email_account_admins       = local.postgresql_server[each.key].threat_detection_policy.email_account_admins
      email_addresses            = local.postgresql_server[each.key].threat_detection_policy.email_addresses
      retention_days             = local.postgresql_server[each.key].threat_detection_policy.retention_days
      storage_account_access_key = local.postgresql_server[each.key].threat_detection_policy.storage_account_access_key
      storage_endpoint           = local.postgresql_server[each.key].threat_detection_policy.storage_endpoint
    }
  }

  tags = local.postgresql_server[each.key].tags
}

resource "azurerm_postgresql_database" "postgresql_database" {
  for_each = var.postgresql_database

  name                = local.postgresql_database[each.key].name == "" ? each.key : local.postgresql_database[each.key].name
  resource_group_name = local.postgresql_database[each.key].resource_group_name
  server_name         = local.postgresql_database[each.key].server_name
  charset             = local.postgresql_database[each.key].charset
  collation           = local.postgresql_database[each.key].collation
}

resource "azurerm_postgresql_virtual_network_rule" "postgresql_virtual_network_rule" {
  for_each = var.postgresql_virtual_network_rule

  name                = local.postgresql_virtual_network_rule[each.key].name == "" ? each.key : local.postgresql_virtual_network_rule[each.key].name
  resource_group_name = local.postgresql_virtual_network_rule[each.key].resource_group_name
  server_name = local.postgresql_virtual_network_rule[each.key].server_name
  subnet_id = local.postgresql_virtual_network_rule[each.key].subnet_id
  ignore_missing_vnet_service_endpoint = local.postgresql_virtual_network_rule[each.key].ignore_missing_vnet_service_endpoint
}

resource "azurerm_postgresql_firewall_rule" "postgresql_firewall_rule" {
  for_each = var.postgresql_firewall_rule

  name                = local.postgresql_firewall_rule[each.key].name == "" ? each.key : local.postgresql_firewall_rule[each.key].name
  resource_group_name = local.postgresql_firewall_rule[each.key].resource_group_name
  server_name         = local.postgresql_firewall_rule[each.key].server_name
  start_ip_address    = local.postgresql_firewall_rule[each.key].start_ip_address
  end_ip_address      = local.postgresql_firewall_rule[each.key].end_ip_address
}
