variable "vms" {
  type = map(object({
    nic_name            = string
    location            = string
    resource_group_name = string
    vm_name             = string
    size                = string
  }))
}