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

variable "prefix" {
  default = "maria-terraform"
}

# Grupo de recursos
resource "azurerm_resource_group" "rg-tf" {
  name     = "${var.prefix}-dev"
  location = "East US"
}

resource "azurerm_kubernetes_cluster" "aks-tf" {
  name                = "${var.prefix}-aks1"
  location            = azurerm_resource_group.rg-tf.location
  resource_group_name = azurerm_resource_group.rg-tf.name
  dns_prefix          = "mariaterraformaks1"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }

}

# está capturando o arquivo de configuração completo do Kubernetes
output "kube_config" {
  value = azurerm_kubernetes_cluster.aks-tf.kube_config_raw
  sensitive = true
}

/*
Como Usar os Outputs:
terraform output <nome_do_output>
*/