# init
rgName=whoamicoreDev
subId=subscription-id-goes-here
location=westus
aksName=whoamicoreAksDev
acrName=whoamicoreAcrDev
acrSku=Standard
spnId=azsubspn

# login
az login
az account set --subscription $subId

# create resource group
az group create -l $location -n $rgName

# create service principal... for demo purposes permissions are failry loose. please set stricter permissions in real world scenarios 
az ad sp create-for-rbac \
    --name $spnId \
    --role contributor \
    --scopes /subscriptions/subscription-id-goes-here \
    --sdk-auth
# {
#   "clientId": "client-id-goes-here",
#   "clientSecret": "client-secret-goes-here",
#   "subscriptionId": "subscription-id-goes-here",
#   "tenantId": "tenant-id-goes-here",
#   "activeDirectoryEndpointUrl": "https://login.microsoftonline.com",
#   "resourceManagerEndpointUrl": "https://management.azure.com/",
#   "activeDirectoryGraphResourceId": "https://graph.windows.net/",
#   "sqlManagementEndpointUrl": "https://management.core.windows.net:8443/",
#   "galleryEndpointUrl": "https://gallery.azure.com/",
#   "managementEndpointUrl": "https://management.core.windows.net/"
# }

# create aks... again for demo purposes cluster configuration is very generic. please be more diligent in real world scenarios
az aks create \
    --resource-group $rgName \
    --name $aksName \
    --service-principal $clientId \
    --client-secret $clientSecret

# create acr... for demo purposes it's not locked down
az acr create --name $acrName \
    --resource-group $rgName \
    --sku $acrSku
