subscription_id     = "525c7c1f-f5e9-4bf4-8d7a-5b7a06889a12"
resource_group_name = "terraform-dev"
location            = "uksouth"

aks_name     = "orchard-aks-dev"
dns_prefix   = "orchardaksdev"
aks_sku_tier = "Free"
node_count   = 2 # minimum for Helm topology spread (2 replicas across nodes)
node_vm_size = "Standard_B2s"

acr_name = "orchardacrdev001"
acr_sku  = "Basic"

sql_server_name          = "orchard-sql-dev-001"
sql_admin_login          = "sqladmin"
sql_admin_password       = "Password123?!?"
sql_databases            = ["OrchardDb"]
sql_database_sku_name    = "Basic"
sql_database_max_size_gb = 2

tags = {
  environment = "dev"
  project     = "aks-orchard-microservice"
}
