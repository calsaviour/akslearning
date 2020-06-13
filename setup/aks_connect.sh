#!/bin/bash -
# VARIABLES
VNUM=1.0.0
USERNAME=null
PASSWORD=null
RESOURCE_GROUP="demoAKSLab"
CLUSTER_NAME="myAKSCluster"
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
az account set --subscription $SUBSCRIPTION
az aks get-credentials --resource-group ${RESOURCE_GROUP} --name ${CLUSTER_NAME} --admin
kubectl get ns
