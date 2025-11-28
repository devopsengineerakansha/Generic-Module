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
