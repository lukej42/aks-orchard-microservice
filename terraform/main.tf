terraform {
  required_version = ">= 1.5.0"

  backend "azurerm" {
    resource_group_name  = "terraform-deploy"
    storage_account_name = "terraformsflg"
    container_name       = "aks-orchard-microservice"
    key                  = "dev.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.75.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

module "aks" {
  source = "./modules/aks"

  aks_name            = var.aks_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  dns_prefix          = var.dns_prefix
  sku_tier            = var.aks_sku_tier
  node_count          = var.node_count
  node_vm_size        = var.node_vm_size
  kubernetes_version  = var.kubernetes_version
}

module "acr" {
  source = "./modules/acr"

  acr_name            = var.acr_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  acr_sku             = var.acr_sku
  aks_principal_id    = module.aks.kubelet_identity_object_id
}

module "sql" {
  source = "./modules/sql"

  resource_group_name  = azurerm_resource_group.main.name
  location             = azurerm_resource_group.main.location
  server_name          = var.sql_server_name
  admin_login          = var.sql_admin_login
  admin_password       = var.sql_admin_password
  databases            = var.sql_databases
  database_sku_name    = var.sql_database_sku_name
  database_max_size_gb = var.sql_database_max_size_gb
  firewall_rules       = var.sql_firewall_rules
}
