# aro_install.sh
# Create the ARO resource group, vnet, subnets, and cluster

REGION=eastus
RESOURCE_GROUP=openenv-fmh8x
VNET_NAME=aro-vnet-hub
MASTER_SUBNET=master-subnet
WORKER_SUBNET=worker-subnet
CLUSTER_NAME=aro-cluster
OCP_PULL_SECRET=./pull_secret.txt

MASTER_SIZE=Standard_D8s_v3
WORKER_SIZE=Standard_D8s_v3
WORKER_COUNT=3

echo
echo "Your ARO cluster will be created at the following region: " ${REGION}
echo "Resource group name is                                  : " ${RESOURCE_GROUP}
echo "Your ARO cluster name is                                : " ${CLUSTER_NAME}
echo

az provider register -n Microsoft.RedHatOpenShift --wait
az provider register -n Microsoft.Compute --wait
az provider register -n Microsoft.Storage --wait

# Create the resource group
az group create --name $RESOURCE_GROUP --location $REGION

# Create the vnet
az network vnet create \
   --resource-group $RESOURCE_GROUP \
   --name $VNET_NAME \
   --address-prefixes 10.0.0.0/22

# Create the master subnet
az network vnet subnet create \
   --resource-group $RESOURCE_GROUP \
   --vnet-name $VNET_NAME \
   --name $MASTER_SUBNET \
   --address-prefixes 10.0.0.0/23 \
   --service-endpoints Microsoft.ContainerRegistry

# Create the worker subnet
az network vnet subnet create \
   --resource-group $RESOURCE_GROUP \
   --vnet-name $VNET_NAME \
   --name $WORKER_SUBNET \
   --address-prefixes 10.0.2.0/23 \
   --service-endpoints Microsoft.ContainerRegistry

# Update the master subnet to disable private link service network policies
az network vnet subnet update \
   --name $MASTER_SUBNET \
   --resource-group $RESOURCE_GROUP \
   --vnet-name $VNET_NAME \
   --disable-private-link-service-network-policies true

# Create the ARO cluster
az aro create \
   --resource-group $RESOURCE_GROUP \
   --name $CLUSTER_NAME \
   --vnet $VNET_NAME \
   --master-subnet $MASTER_SUBNET \
   --worker-subnet $WORKER_SUBNET \
   --worker-count   ${WORKER_COUNT} \
   --pull-secret @$OCP_PULL_SECRET
#   --master-vm-size ${MASTER_SIZE}  \
#   --worker-vm-size ${WORKER_SIZE}  \

echo
echo "To access Red Hat OpenShift console plase direct you browser to the following url: "
echo 

az aro show \
    --name $CLUSTER_NAME \
    --resource-group $RESOURCE_GROUP \
    --query "consoleProfile.url" -o tsv

# Retrieve Red Hat OpenShift kubeadmin password.

echo
echo "... and login with the following credentials: "
echo

az aro list-credentials \
  --name $CLUSTER \
  --resource-group $RESOURCEGROUP   