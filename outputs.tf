output "postgresql_server" {
  description = "azurerm_postgresql_server"
  value = {
    for postgresql_server in keys(azurerm_postgresql_server.postgresql_server) :
    postgresql_server => {
      id   = azurerm_postgresql_server.postgresql_server[postgresql_server].id
      name = azurerm_postgresql_server.postgresql_server[postgresql_server].name
      fqdn = azurerm_postgresql_server.postgresql_server[postgresql_server].fqdn
      version = azurerm_postgresql_server.postgresql_server[postgresql_server].version
      administrator_login = azurerm_postgresql_server.postgresql_server[postgresql_server].administrator_login
      administrator_login_password = azurerm_postgresql_server.postgresql_server[postgresql_server].administrator_login_password
    }
  }
}
output "postgresql_database" {
  description = "azurerm_postgresql_database"
  value = {
    for postgresql_database in keys(azurerm_postgresql_database.postgresql_database) :
    postgresql_database => {
      id   = azurerm_postgresql_database.postgresql_database[postgresql_database].id
      name = azurerm_postgresql_database.postgresql_database[postgresql_database].name
    }
  }
}
