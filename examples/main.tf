module "postgresql" {
  source = "registry.terraform.io/T-Systems-MMS/postgresql/azurerm"
  postgresql_server = {
    master = {
      name                         = "master-psql"
      location                     = "westeurope"
      resource_group_name          = "rg-service-env"
      sku_name                     = "B_Gen5_2"
      version                      = "11"
      administrator_login          = "dba"
      administrator_login_password = data.azurerm_key_vault_secret.dba.value
      backup_retention_days        = "7"
      geo_redundant_backup_enabled = false
      ssl_enforcement_enabled      = true
      storage_mb                   = "5120"
      /** Basic tier does not support false option */
      public_network_access_enabled = true
    }
  }
  postgresql_firewall_rule = {
    master = {
      name                = "proxy"
      resource_group_name = "rg-service-env"
      server_name         = module.postgresql.postgresql_server.master.name
      start_ip_address    = "127.0.0.1"
      end_ip_address      = "127.0.0.1"
    }
  }
}
