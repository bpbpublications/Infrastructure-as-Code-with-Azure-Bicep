param location string
param appServiceAppName string
param appServicePlanName string
param appServicePlanSkuName string
param minTlsVersion string
param identityType string
param storageAccountName string
param storageAccountSkuName string
param storageAccountKind string

resource appServicePlan 'Microsoft.Web/serverfarms@2021-01-15' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSkuName
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountSkuName
  }
  kind: storageAccountKind
}

resource appServiceApp 'Microsoft.Web/sites@2021-01-15' = {
  name: appServiceAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      minTlsVersion: minTlsVersion
    }
  }
  identity: {
    type: identityType
  }
}
