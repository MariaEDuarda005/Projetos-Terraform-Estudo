# código de inicialização do terraform
terraform {
  required_version = ">=1.10.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.19.0"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false # Desabilitar a verificação se existe algum recurso dentro o grupo de recursos
    }
  }
}

locals {
  environment_prefix      = "dev"
  resource_group_name     = "terraform-${local.environment_prefix}"
  resource_group_location = "East US"
  tags = {
    Project      = "terraform-${local.environment_prefix}" #⚠️#
    Owner        = "maria_ferreira"                        #⚠️#
    CreationDate = "21/02/2025"                            #⚠️#
    Environment  = local.environment_prefix                #⚠️#
  }
}

module "azurerg" {
  source = "./modules/azurerg"

  resource_group_name     = local.resource_group_name # Quando cria um cluster AKS da Azure ele salva assim -> MC_<resource_group_name>_<kubernetes_cluster_name>_<location>

  resource_group_location = local.resource_group_location
  tags                    = local.tags
}

module "kubernetes" {
  source = "./modules/kubernetes"

  kubernetes_name         = "terraform-dev-aks1"
  resource_group_location = local.resource_group_location
  resource_group_name     = local.resource_group_name
  kubernetes_dns_prefix   = "mariaterraformaks1"

  name_default_node_pool = "default"
  node_count             = 1
  vm_size                = "Standard_D2_v2"

  type = "SystemAssigned"

  tag_environment = "Production"
}

# output "kube_config" {
#   value = azurerm_kubernetes_cluster.aks-tf.kube_config_raw
#   sensitive = true
# }