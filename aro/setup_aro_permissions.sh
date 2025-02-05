#!/bin/bash

# Login to Azure (if not already logged in)
az account show &> /dev/null || az login

# Get the signed-in user's Object ID
SIGNED_IN_USER_ID=$(az ad signed-in-user show --query id -o tsv)

# Get subscription ID
SUBSCRIPTION_ID=$(az account show --query id -o tsv)

# Assign Global Administrator role (this requires an admin to approve)
echo "Requesting Global Administrator role..."
az rest --method post \
  --uri "https://graph.microsoft.com/v1.0/roleManagement/directory/roleAssignments" \
  --body "{\"principalId\":\"$SIGNED_IN_USER_ID\",\"roleDefinitionId\":\"62e90394-69f5-4237-9190-012177145e10\",\"directoryScopeId\":\"/\"}"

# Assign Azure AD permissions
echo "Assigning Azure AD permissions..."
az role assignment create \
  --assignee-object-id "$SIGNED_IN_USER_ID" \
  --role "User Access Administrator" \
  --scope "/subscriptions/$SUBSCRIPTION_ID"

az role assignment create \
  --assignee-object-id "$SIGNED_IN_USER_ID" \
  --role "Contributor" \
  --scope "/subscriptions/$SUBSCRIPTION_ID"

# Register required resource providers
echo "Registering required resource providers..."
az provider register -n Microsoft.RedHatOpenShift --wait
az provider register -n Microsoft.Compute --wait
az provider register -n Microsoft.Storage --wait
az provider register -n Microsoft.Authorization --wait

echo "Setup complete. Please wait a few minutes for the permissions to propagate."
echo "Note: You may need to log out and log back in for the permissions to take effect."