

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault" {
  for_each = var.key_vaults

  name                        = each.value.name
  location                    = each.value.location
  resource_group_name         = each.value.resource_group_name
  enabled_for_disk_encryption = each.value.enabled_for_disk_encryption
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = each.value.soft_delete_retention_days
  purge_protection_enabled    = each.value.purge_protection_enabled

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
      "List",
      "Delete",
      "Create",
      "Update"
    ]

  secret_permissions = [
     "Get",
     "List",
     "Set",
     "Delete"
]
  

    storage_permissions = [
      "Get",
    ]
  }
}

resource "azurerm_key_vault_secret" "secret" {
  for_each = var.key_vault_secret

  name  = each.value.name
  value = each.value.value

  # ✔ Correct reference – use the key 'key_vault_key'
  key_vault_id = azurerm_key_vault.keyvault[each.value.key_vault_key].id
}
