variable "rgs"{
  type = map (object({
  name     = string
  location = string
  managed_by = string
  tags = map (string)
    }))
}
 
variable "networks" {
  description = "VNet configuration with subnets"

  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    address_space       = list(string)
    dns_servers         = optional(list(string))
    tags                = optional(map(string))

    subnet = optional(map(object({
      name             = string
      address_prefixes = list(string)
    })))
  }))
}

variable "vms" {
  type = map(object({
    nic_name            = string
    location            = string
    resource_group_name = string
    vm_name             = string
    size                = string
  }))
}

 variable "container_registries"{
    type = map(object({
  name                = string
  resource_group_name = string
  location            = string
  sku                 = string
  admin_enabled       = bool

    }))
}

variable "kubernetes_clusters" {
  description = "Map of Kubernetes clusters to be created"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    dns_prefix          = string

    default_node_pool = object({
      name       = string
      node_count = number
      vm_size    = string
    })

    identity_type = string  # <- yahaan sirf ek field hai, isliye object ki zarurat nahi
    tags          = map(string)
  }))
}


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