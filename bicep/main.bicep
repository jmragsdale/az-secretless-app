param namePrefix string = 'secretless'
param location string = resourceGroup().location
@allowed(['demo-api-key']) param secretName string = 'demo-api-key'

resource kv 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: '${namePrefix}-kv'
  location: location
  properties: {
    enablePurgeProtection: true
    enableSoftDelete: true
    sku: { family: 'A', name: 'standard' }
    tenantId: subscription().tenantId
    enableRbacAuthorization: true
  }
}

resource ca 'Microsoft.App/containerApps@2024-03-01' = {
  name: '${namePrefix}-app'
  location: location
  identity: { type: 'SystemAssigned' }
  properties: {
    managedEnvironmentId: ''
    configuration: { ingress: { external: false, targetPort: 8080 } }
    template: {
      containers: [
        { name: 'api', image: 'mcr.microsoft.com/azuredocs/containerapps-helloworld:latest',
          env: [
            { name: 'KV_URL', value: kv.properties.vaultUri },
            { name: 'SECRET_NAME', value: secretName }
          ] }
      ]
    }
  }
}
