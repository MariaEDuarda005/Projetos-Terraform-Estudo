# Projeto Terraform para Infraestrutura no Azure
![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)
![Azure DevOps](https://img.shields.io/badge/Azure_DevOps-0078D7?style=for-the-badge&logo=azure-devops&logoColor=white)

## Visão Geral

Este projeto fornece configurações do Terraform para gerenciar infraestrutura no Azure usando Infraestrutura como Código (IaC). Ele inclui componentes modulares para melhor escalabilidade e manutenibilidade.

## Pré-requisitos

Antes de usar este projeto, certifique-se de ter o seguinte instalado:

- **Terraform**: v1.7.5 or higher ([Download Terraform](https://developer.hashicorp.com/terraform/downloads))
- **Azure CLI**: Installed and authenticated ([Azure CLI Installation Guide](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli))


## Comandos Terraform

Aqui estão os comandos Terraform organizados em uma tabela para facilitar o uso:

| **Comando**                         | **Descrição**                                               |
|-------------------------------------|-------------------------------------------------------------|
| `terraform init`                    | Inicializa o projeto Terraform, baixa os provedores necessários e configura o backend. |
| `terraform fmt`                     | Reformata os arquivos de configuração do Terraform para garantir um estilo consistente. |
| `terraform validate`                | Verifica a configuração em busca de erros de sintaxe e melhores práticas. |
| `terraform plan -out plan.out`      | Gera um plano de execução e o salva em `plan.out`. |
| `terraform apply plan.out`          | Aplica as mudanças planejadas para a infraestrutura no Azure. |
| `terraform destroy`                 | **Aviso:** Este comando irá remover todos os recursos gerenciados pelo Terraform. |


## Melhores Práticas

- Armazene o estado do Terraform de forma segura usando o Azure Storage ou o Terraform Cloud.
- Use variáveis de ambiente para dados sensíveis, evitando codificar credenciais.
- Aproveite o bloqueio de estado remoto para evitar mudanças concorrentes.
- Implemente Pipelines do Azure DevOps para implantações automatizadas.