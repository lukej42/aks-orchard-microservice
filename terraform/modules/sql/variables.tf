variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "server_name" {
  type = string
}

variable "admin_login" {
  type = string
}

variable "admin_password" {
  type      = string
  sensitive = true
}

variable "databases" {
  type = list(string)
}

variable "database_sku_name" {
  type        = string
  description = "Azure SQL database SKU — Basic is the cheapest fixed tier (2 GB max)"
  default     = "Basic"
}

variable "database_max_size_gb" {
  type        = number
  description = "Max database size in GB — Basic tier supports up to 2 GB"
  default     = 2
}

variable "firewall_rules" {
  type = list(object({
    name             = string
    start_ip_address = string
    end_ip_address   = string
  }))
}
