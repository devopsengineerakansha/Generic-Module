variable "key_vaults" {
  type = map(object({
    name                        = string
    location                    = string
    resource_group_name         = string
    enabled_for_disk_encryption = bool
    soft_delete_retention_days  = number
    purge_protection_enabled    = bool
    sku_name                    = string

  }))
}

variable "key_vault_secret" {
  type = map(object({
    name          = string
    value         = string
    key_vault_key = string   # <-- This must match key_vaults ka key
  }))
  default = {}
}
