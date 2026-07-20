variable "subscription_id" {
  type        = string
  description = "Azure subscription ID"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group for Orchard AKS resources"
}

variable "location" {
  type        = string
  description = "Azure region"
  default     = "uksouth"
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to all resources"
  default = {
    project = "aks-orchard-microservice"
  }
}

variable "aks_name" {
  type        = string
  description = "AKS cluster name"
}

variable "dns_prefix" {
  type        = string
  description = "DNS prefix for the AKS API server"
}

variable "node_count" {
  type        = number
  description = "Number of nodes in the default node pool"
  default     = 1
}

variable "node_vm_size" {
  type        = string
  description = "VM size for AKS nodes — Standard_B2s is the cheapest practical burstable size"
  default     = "Standard_B2s"
}

variable "aks_sku_tier" {
  type        = string
  description = "AKS control plane tier — Free ($0/month, no SLA)"
  default     = "Free"
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version for the AKS cluster"
  default     = null
  nullable    = true
}

variable "acr_name" {
  type        = string
  description = "Globally unique ACR name (alphanumeric only, no hyphens)"
}

variable "acr_sku" {
  type        = string
  description = "ACR SKU — Basic is the cheapest tier (10 GB included)"
  default     = "Basic"
}

variable "sql_server_name" {
  type        = string
  description = "Azure SQL server name"
}

variable "sql_admin_login" {
  type        = string
  description = "Azure SQL admin username"
  default     = "sqladmin"
}

variable "sql_admin_password" {
  type        = string
  description = "Azure SQL admin password"
  sensitive   = true
}

variable "sql_databases" {
  type        = list(string)
  description = "Azure SQL databases to create (all Orchard instances share a single database)"
  default     = ["OrchardDb"]
}

variable "sql_database_sku_name" {
  type        = string
  description = "Azure SQL database SKU — Basic is the cheapest fixed tier"
  default     = "Basic"
}

variable "sql_database_max_size_gb" {
  type        = number
  description = "Max database size in GB — Basic tier supports up to 2 GB"
  default     = 2
}

variable "sql_firewall_rules" {
  type = list(object({
    name             = string
    start_ip_address = string
    end_ip_address   = string
  }))
  description = "Firewall rules allowing AKS egress to Azure SQL"
  default     = []
}
