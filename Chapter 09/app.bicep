param location string = 'eastus'
param env string

// Storage Account
resource storageAccount 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  name: '${env}tutorialstore'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}

// App Service Plan
resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: '${env}-tutorial-app-plan'
  location: location
  sku: {
    name: 'B1'
    tier: 'Basic'
    size: 'B1'
    family: 'B'
    capacity: 1
  }
  kind: 'app'
}

// Web App
resource webApp 'Microsoft.Web/sites@2022-03-01' = {
  name: '${env}-tutorial-app'
  location: location
  kind: 'app'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    clientAffinityEnabled: false
    clientCertEnabled: false
    clientCertMode: 'Optional'
    enabled: true
    httpsOnly: true
    serverFarmId: appServicePlan.id
    siteConfig: {
      alwaysOn: false
      appSettings: [
        {
          name: 'environment'
          value: 'development'
        }
      ]
      webSocketsEnabled: true
    }
  }
}

// Cosmos DB Account
resource cosmosDbAccount 'Microsoft.DocumentDB/databaseAccounts@2021-04-15' = {
  name: '${env}-tutorial-db-account'
  location: location
  properties: {
    databaseAccountOfferType: 'Standard'
    enableAutomaticFailover: false
    enableMultipleWriteLocations: false
    consistencyPolicy: {
      defaultConsistencyLevel: 'Session'
    }
    locations: [
      {
        locationName: location
        failoverPriority: 0
        isZoneRedundant: false
      }
    ]
  }
}

// Database
resource cosmosDb 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2021-06-15' = {
  parent: cosmosDbAccount
  name: '${env}-tutorial-db'
  properties:{
    resource:{
      id: '${env}-tutorial-db'
    }
  }
}

// Cosmos DB containers
resource cosmosDbContainer 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2021-06-15' = {
  name:'users'
  parent: cosmosDb
  properties:{
    resource:{
      id: 'users'
      partitionKey:{
        paths:[
          '/id'
        ]
      }
    }
  }
}
