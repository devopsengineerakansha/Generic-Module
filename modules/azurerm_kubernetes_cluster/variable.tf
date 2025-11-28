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
