// main.bicep
module storageSpec 'br:demotemplateregistry.azurecr.io/bicep/storagemodule:v1.0' = {
  name: 'storageDeployment'
  params: {
    storageAccountName: 'bicepbookteststore2'
    location: 'eastus'
 }
}
