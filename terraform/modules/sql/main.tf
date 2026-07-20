resource "azurerm_mssql_server" "server" {
  name                         = var.server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.admin_login
  administrator_login_password = var.admin_password
  minimum_tls_version          = "1.2"
}

resource "azurerm_mssql_database" "databases" {
  for_each = toset(var.databases)

  name        = each.value
  server_id   = azurerm_mssql_server.server.id
  sku_name    = var.database_sku_name
  max_size_gb = var.database_max_size_gb
}

resource "azurerm_mssql_firewall_rule" "rules" {
  for_each = { for rule in var.firewall_rules : rule.name => rule }

  name             = each.value.name
  server_id        = azurerm_mssql_server.server.id
  start_ip_address = each.value.start_ip_address
  end_ip_address   = each.value.end_ip_address
}

# Allow Azure services (AKS egress via Azure backbone)
resource "azurerm_mssql_firewall_rule" "allow_azure" {
  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

output "server_fqdn" {
  value = azurerm_mssql_server.server.fully_qualified_domain_name
}

output "database_names" {
  value = [for db in azurerm_mssql_database.databases : db.name]
}
