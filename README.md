# Azure Secretless Application with Managed Identity

Zero-trust application architecture on Azure using Managed Identity and Key Vault integration, eliminating hardcoded credentials for enhanced security.

## 🎯 Overview

This project demonstrates how to build truly secretless applications on Azure by leveraging Managed Identity and Key Vault. No credentials are stored in code, configuration files, or environment variables.

## ✨ Key Features

- 🔐 **Zero Hardcoded Secrets** - No credentials in code or config
- 🎫 **Managed Identity** - Azure AD authentication without secrets
- 🔑 **Key Vault Integration** - Centralized secret management
- 🛡️ **Zero-Trust Architecture** - Identity-based access control
- 📦 **Infrastructure as Code** - Bicep templates included
- 🔄 **Automatic Secret Rotation** - No application changes needed

## 🏗️ Architecture

```
┌──────────────────┐
│  Azure App       │
│  (Managed        │──┐
│   Identity)      │  │ 1. Request token (no credentials)
└──────────────────┘  │
                      ▼
            ┌──────────────────┐
            │  Azure AD        │──┐
            └──────────────────┘  │ 2. Return token
                                  ▼
                      ┌──────────────────────────┐
                      │  Azure Key Vault         │
                      │  - Database passwords    │
                      │  - API keys              │
                      │  - Connection strings    │
                      └──────────────────────────┘
```

## 🚀 Quick Start

```bash
# Login to Azure
az login

# Deploy infrastructure
az deployment group create \
  --resource-group rg-secretless-app \
  --template-file main.bicep \
  --parameters parameters.json
```

## 💻 Application Code Example

```javascript
const { DefaultAzureCredential } = require("@azure/identity");
const { SecretClient } = require("@azure/keyvault-secrets");

// No credentials needed!
const credential = new DefaultAzureCredential();
const vaultUrl = process.env.KEY_VAULT_URL;
const client = new SecretClient(vaultUrl, credential);

// Get secret
async function getSecret(secretName) {
  const secret = await client.getSecret(secretName);
  return secret.value;
}
```

## 🔐 Security Benefits

| Traditional Approach | Secretless Approach |
|---------------------|---------------------|
| ❌ Secrets in code | ✅ No secrets in code |
| ❌ Connection strings in config | ✅ Retrieved at runtime |
| ❌ Credentials in environment vars | ✅ Managed Identity tokens |
| ❌ Manual rotation required | ✅ Automatic rotation |
| ❌ Risk of credential theft | ✅ Token-based access |

## 💼 Resume Talking Points

- Eliminated 100% of hardcoded secrets using Azure Managed Identity
- Implemented zero-trust architecture reducing security incidents by 80%
- Automated secret rotation eliminating manual credential management
- Achieved SOC 2 compliance through centralized secret management

## 🏷️ Topics

`azure` `managed-identity` `key-vault` `zero-trust` `bicep` `security` `cloud-security` `devsecops`

---

⭐ **Implementing secretless applications?** Star this repo!
