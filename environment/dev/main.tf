module "resource_group" {
  source = "../../modules/azurerm_resource_group"
  rgs    = var.rgs
}

module "networks" {
  source     = "../../modules/azurerm_networking"
  networks   = var.networks
  depends_on = [module.resource_group]
}

module "sql_server" {
  source                       = "../../modules/azurerm_sql_server"
  sql_server_name              = "todosqlserver008"
  resource_group_name          = "rg-akansha"
  location                     = "centralindia"
  administrator_login          = "sqladmin"
  administrator_login_password = var.administrator_login_password
}

module "sql_database" {
  depends_on          = [module.sql_server]
  source              = "../../modules/azurerm_sql_database"
  sql_server_name     = "todosqlserver008"
  resource_group_name = "rg-akansha"
  sql_database_name   = "tododb"
}

module "container_registry" {
  source               = "../../modules/azurerm_container_registry"
  depends_on           = [module.resource_group]
  container_registries = var.container_registries
}

module "key_vault" {
  source           = "../../modules/azurerm_key_vault"
  depends_on       = [module.resource_group]
  key_vaults       = var.key_vaults
  key_vault_secret = var.key_vault_secret
}

module "kubernetes_cluster" {
  source              = "../../modules/azurerm_kubernetes_cluster"
  depends_on          = [
    module.resource_group,
    module.container_registry,
    module.key_vault
  ]
  kubernetes_clusters = var.kubernetes_clusters
}
