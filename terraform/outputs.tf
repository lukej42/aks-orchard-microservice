output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "aks_name" {
  value = module.aks.aks_name
}

output "aks_kube_config" {
  value     = module.aks.kube_config
  sensitive = true
}

output "acr_login_server" {
  value = module.acr.login_server
}

output "sql_server_fqdn" {
  value = module.sql.server_fqdn
}

output "sql_database_names" {
  value = module.sql.database_names
}
