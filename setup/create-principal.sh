#!/bin/bash

# Login to Azure
az login

# List subscriptions
az account list --output table

# Select subscription
az account set --subscription "calvin-demo"

# Valdiate that the correct subscription is selected
az account list --query "[?isDefault==\`true\`]" --output table

# Create variables with the subscription data
TenantID=$(az account list --query "[?isDefault==\`true\`].tenantId" --output tsv)
SubscriptionID=$(az account list --query "[?isDefault==\`true\`].id" --output tsv)

# Create Service Principal
# Store the password in a safe place and write down that it will expire in a year
# This will make the service principal contributor to the subscription
az ad sp create-for-rbac --name sp-aks
ClientID=$(az ad sp list --query "[?appDisplayName=='sp-aks'].appId" --output tsv