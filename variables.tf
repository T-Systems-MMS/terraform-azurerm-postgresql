variable "postgresql_server" {
  type        = any
  default     = {}
  description = "resource definition, default settings are defined within locals and merged with var settings"
}
variable "postgresql_database" {
  type        = any
  default     = {}
  description = "resource definition, default settings are defined within locals and merged with var settings"
}
variable "postgresql_virtual_network_rule" {
  type        = any
  default     = {}
  description = "resource definition, default settings are defined within locals and merged with var settings"
}
variable "postgresql_firewall_rule" {
  type        = any
  default     = {}
  description = "resource definition, default settings are defined within locals and merged with var settings"
}

locals {
  default = {
    # resource definition
    postgresql_server = {
      name                              = ""
      administrator_login               = null
      administrator_login_password      = null
      auto_grow_enabled                 = false
      backup_retention_days             = null
      create_mode                       = "Default"
      creation_source_server_id         = null
      geo_redundant_backup_enabled      = null
      infrastructure_encryption_enabled = false
      public_network_access_enabled     = true
      restore_point_in_time             = null
      ssl_enforcement_enabled           = true
      ssl_minimal_tls_version_enforced  = null
      storage_mb                        = null
      identity                          = {}
      threat_detection_policy           = {}
      tags                              = {}
    }
    postgresql_database = {
      name = ""
    }
    postgresql_virtual_network_rule = {
      name = ""
      ignore_missing_vnet_service_endpoint = true
    }
    postgresql_firewall_rule = {
      name = ""
    }
  }

  # compare and merge custom and default values
  postgresql_server_values = {
    for postgresql_server in keys(var.postgresql_server) :
    postgresql_server => merge(local.default.postgresql_server, var.postgresql_server[postgresql_server])
  }
  # merge all custom and default values
  postgresql_server = {
    for postgresql_server in keys(var.postgresql_server) :
    postgresql_server => merge(
      local.postgresql_server_values[postgresql_server],
      {
        for config in ["identity", "threat_detection_policy"] :
        config => merge(local.default.postgresql_server[config], local.postgresql_server_values[postgresql_server][config])
      }
    )
  }
  postgresql_database = {
    for postgresql_database in keys(var.postgresql_database) :
    postgresql_database => merge(local.default.postgresql_database, var.postgresql_database[postgresql_database])
  }
  postgresql_virtual_network_rule = {
    for postgresql_virtual_network_rule in keys(var.postgresql_virtual_network_rule) :
    postgresql_virtual_network_rule => merge(local.default.postgresql_virtual_network_rule, var.postgresql_virtual_network_rule[postgresql_virtual_network_rule])
  }
  postgresql_firewall_rule = {
    for postgresql_firewall_rule in keys(var.postgresql_firewall_rule) :
    postgresql_firewall_rule => merge(local.default.postgresql_firewall_rule, var.postgresql_firewall_rule[postgresql_firewall_rule])
  }
}
