#!/bin/bash

# Get AKS cluster credentials
az aks get-credentials \
  --resource-group "aks-resource-group" \
  --name "rhacm-connected-aks" \
  --overwrite-existing