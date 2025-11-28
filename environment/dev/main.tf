module "resource_group" {
  source = "../../modules/azurerm_resource_group"
  rgs    = var.rgs
}

module "networks" {
  source      = "../../modules/azurerm_networking"
  networks      = var.networks
  depends_on  = [module.resource_group]
}


module "container_registry" {
  source                = "../../modules/azurerm_container_registry"
  depends_on            = [module.resource_group]       # ✅ Fix: depends_on me [] list hoti hai
  container_registries  = var.container_registries
}

module "key_vault" {
  source       = "../../modules/azurerm_key_vault"
  depends_on   = [module.resource_group]                # ✅ optional but recommended
  key_vaults   = var.key_vaults
  key_vault_secret = var.key_vault_secret
}



module "kubernetes_cluster" {
  source                = "../../modules/azurerm_kubernetes_cluster"
  depends_on            = [
    module.resource_group,
    module.container_registry,
    module.key_vault
  ]                                                    # ✅ ensures dependencies are created first
  kubernetes_clusters    = var.kubernetes_clusters
}
