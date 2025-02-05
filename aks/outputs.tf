output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks_cluster.name
}

output "aks_cluster_resource_group" {
  value = azurerm_resource_group.aks_rg.name
}

output "aks_cluster_kube_config" {
  value     = azurerm_kubernetes_cluster.aks_cluster.kube_config_raw
  sensitive = true
}

output "aks_cluster_host" {
  value = azurerm_kubernetes_cluster.aks_cluster.kube_config[0].host
  sensitive = true
}