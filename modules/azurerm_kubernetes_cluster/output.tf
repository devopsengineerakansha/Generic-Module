output "cluster_ids"{
value = {for k,v in azurerm_kubernetes_cluster.cluster : k => v.id }
}