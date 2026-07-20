variable "aks_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "dns_prefix" {
  type = string
}

variable "sku_tier" {
  type        = string
  description = "AKS control plane tier — Free is $0/month (no SLA, suitable for dev/test)"
  default     = "Free"
}

variable "node_count" {
  type = number
}

variable "node_vm_size" {
  type = string
}

variable "os_disk_size_gb" {
  type        = number
  description = "Ephemeral OS disk size in GB (no managed disk charge)"
  default     = 30
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version — leave null to use the AKS default for the region"
  default     = null
  nullable    = true
}
