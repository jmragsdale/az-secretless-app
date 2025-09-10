# Azure Secretless App (Managed Identity + Key Vault)
Container App fetches secrets via Managed Identity from Key Vault over private networking (see branch `private-endpoint`).
## Deploy
az group create -n rg-secretless -l eastus
az deployment group create -g rg-secretless -f bicep/main.bicep
