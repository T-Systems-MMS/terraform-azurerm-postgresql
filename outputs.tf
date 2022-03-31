output "postgresql_server" {
  description = "azurerm_postgresql_server"
  value = {
    for postgresql_server in keys(azurerm_postgresql_server.postgresql_server) :
    postgresql_server => {
      id   = azurerm_postgresql_server.postgresql_server[postgresql_server].id
      name = azurerm_postgresql_server.postgresql_server[postgresql_server].name
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
