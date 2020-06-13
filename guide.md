**[HOW TO DEPLOY]**

`aks_create_scale.yml` ansible playbook can be used both for deploying new AKS cluster. It creates AKS managed service.
The application is deployed by executing the following commands:
```
conda create -n python38 python=3.8 anaconda
conda activate python38

./create-principal.sh

export AZURE_CLIENT_ID=$(az ad sp list --query "[?appDisplayName=='sp-aks'].appId" --output tsv)

export AZURE_CLIENT_SECRET=<password>

ansible-playbook aks_create_scale.yml
ansible-playbook application_deployment.yml -e env=${ENVIRONMENT} (example:prod)
```


[OPTIONAL COMMANDS]

```
kubectl get all --all-namespaces -o wid

kubectl config get-contexts
kubectl config use-context myAKSCluster-admin
kubectl get nodes

kubectl get service -n app-prod
kubectl get deployment -n app-prod
kubectl get pods -n app-prod

```

Build Dockerfile
```
cd docker
docker build -t calsaviour/thalestest:thalestest .
docker run -p 8080:8080 -d -t calsaviour/thalestest:thalestest

http://localhost:8080
http://localhost:8080/ip/
http://localhost:8080/test/


```

Enable cluster autoscale if VM are VMSS agentpools

Operation failed with status: 'Bad Request'. Details: AgentPool APIs supported only for clusters with VMSS agentpools. For more information, please check https://aka.ms/multiagentpoollimitations

```
az aks nodepool update \
  --enable-cluster-autoscale \
  --resource-group $RESOURCE_GROUP \
  --cluster-name $CLUSTER_NAME \
  --name default \
  --min-count 1 \
  --max-count 5

```