subscription_id    = "${env.SUBSCRIPTION}"
location           = "eastus"
environment        = "production"
aks_cluster_name   = "rhacm-connected-aks"
aks_node_count     = 3
aks_node_size      = "Standard_D4s_v3"