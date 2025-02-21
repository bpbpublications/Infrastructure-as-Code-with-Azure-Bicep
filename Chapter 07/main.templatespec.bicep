// main.bicep
module storageSpec 'ts:<subcription-id-here>/templateSpecRG/storageSpec:1.0' = {
  name: 'storageDeployment'
  params: {
    storageAccountName: 'bicepbookteststore'
    location: 'eastus'
  }
}
