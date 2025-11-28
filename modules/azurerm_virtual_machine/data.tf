data "azurerm_subnet" "subnet" {
    for_each = var.vms
  name                 = each.value.name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_key_vault" "keyvault" {
  name                = "keyvaultsonaaku"
  resource_group_name = "rg-akansha"
}

data "azurerm_key_vault_secret" "username" {
  name         = "Username"
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "username" {
  name         = "Password"
  key_vault_id = data.azurerm_key_vault.keyvault.id
}