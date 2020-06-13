#!/bin/bash -
# VARIABLES
VNUM=1.0.0
USERNAME=null
PASSWORD=null
SUBSCRIPTION="Pay-As-You-Go"

function usage {
    echo "Usage:"
    echo "  aks_connect.sh [-v|--version] [-h|--help] [(--username  value)...]"
    echo "The available commands for execution are listed below."
    echo
    echo "Arguments:"
    echo "  -v | --version     : Display script version"
    echo "  -h | --help        : Print script usage"
    echo "  --username | -u    : Username to use for authentication in Azure"
    echo "  --password | -p    : Password to use for authentication in Azure"
    echo
    echo "Examples:"
    echo "  ./aks_connect.sh --username The_Donald -p M4keUSAGr3atAga1n"
    exit 1
}

# USAGE
if [[ $# -eq 0 ]]; then
    usage
fi

# PARSE ARGUMENTS
while [[ $# -gt 0 ]]
do
key=$1
case $key in
    -v|--version)
    printf "$VNUM"
    ;;
    -h|--help)
    usage
    ;;
    --username|-u)
    shift # past "--parameter"
    if [ $USERNAME == null ]; then USERNAME=$1; fi
    ;;
    --password|-p)
    shift # past "--parameter"
    if [ $PASSWORD == null ]; then PASSWORD=$1; fi
    ;;
    *)
    shift
    ;;
esac
done

# ACTUAL CODE
az login -u $USERNAME@msn.com -p $PASSWORD
# Login to Azure
az login

# List subscriptions
az account list --output table

# Select subscription
az account set --subscription $SUBSCRIPTION

# Valdiate that the correct subscription is selected
az account list --query "[?isDefault==\`true\`]" --output table

# Create variables with the subscription data
TenantID=$(az account list --query "[?isDefault==\`true\`].tenantId" --output tsv)
SubscriptionID=$(az account list --query "[?isDefault==\`true\`].id" --output tsv)

# Create Service Principal
# Store the password in a safe place and write down that it will expire in a year
# This will make the service principal contributor to the subscription
az ad sp create-for-rbac --name sp-aks
export AZURE_CLIENT_ID=$(az ad sp list --query "[?appDisplayName=='sp-aks'].appId" --output tsv)
