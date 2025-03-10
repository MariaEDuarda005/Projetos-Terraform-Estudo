variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "resource_group_location" {
  description = "The location of the resource group."
  type        = string
}

variable "kubernetes_name" {
  description = "The name of the Kubernetes cluster."
  type = string
}

variable "kubernetes_dns_prefix" {
  description = "The DNS prefix for the Kubernetes cluster."
  type        = string
}

# Variáveis para o pool de nós do AKS
variable "name_default_node_pool" {
  description = "The name of the default node pool."
  type        = string
  default     = "default"
}

variable "node_count" {
  description = "The number of nodes in the default node pool."
  type        = number
  default     = 1
}

variable "vm_size" {
  description = "The size of the virtual machines in the default node pool."
  type        = string
  default     = "Standard_D2_v2"
}

# Variáveis para a identidade
variable "type" {
  description = "The type of the identity for the Kubernetes cluster."
  type        = string
  default     = "SystemAssigned"
}

# Variável para tags
variable "tag_environment" {
  description = "The environment tag for the resource."
  type        = string
  default     = "Production"
}