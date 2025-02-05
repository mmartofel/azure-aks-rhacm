OCP_PULL_SECRET=./pull_secret.txt

az network vnet create --resource-group openenv-fmh8x --name aro-vnet-fmh8x --address-prefixes 10.0.0.0/22
az network vnet subnet create --resource-group openenv-fmh8x --vnet-name aro-vnet-fmh8x --name master-subnet --address-prefixes 10.0.0.0/23 --service-endpoints Microsoft.ContainerRegistry
az network vnet subnet create --resource-group openenv-fmh8x --vnet-name aro-vnet-fmh8x --name worker-subnet --address-prefixes 10.0.2.0/23 --service-endpoints Microsoft.ContainerRegistry
az network vnet subnet update --name master-subnet --resource-group openenv-fmh8x --vnet-name aro-vnet-fmh8x --disable-private-link-service-network-policies true
az aro create --resource-group openenv-fmh8x --name aro-cluster-fmh8x --vnet aro-vnet-fmh8x --master-subnet master-subnet --worker-subnet worker-subnet --pull-secret @$OCP_PULL_SECRET