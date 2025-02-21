param location string = 'eastus'
param resourceBaseName string = 'tutorial-bicep'
param storageAccountName string = 'tutorialbcppstore'

module webApp '../modules/webApp.bicep' = {
  name: 'app-service'
  params: {
    appServiceAppName: '${resourceBaseName}-app'
    appServicePlanName: '${resourceBaseName}-plan'
    appServicePlanSkuName: 'S1'
    identityType: 'SystemAssigned'
    minTlsVersion: '1.2'
    location: location
    storageAccountKind: 'StorageV2'
    storageAccountName: storageAccountName
    storageAccountSkuName: 'Standard_LRS'
  }
}
