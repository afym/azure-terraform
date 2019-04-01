# Installing Terraform in local machine

### Basic commands env variables

```
export SUBSCRIPTION_ID=foo
echo $SUBSCRIPTION_ID
unset SUBSCRIPTION_ID
echo $SUBSCRIPTION_ID
```

### Configuring access to terraform

```
# Find your subscription (/Microsoft_Azure_Billing/ModernBillingMenuBlade/Subscriptions)
az account show --query "{subscriptionId:id, tenantId:tenantId}"
```

```
# Set your subscription as the main one
export SUBSCRIPTION_ID=<subscription_id>
```

```
# Select your subscription
az account set --subscription="${SUBSCRIPTION_ID}"
```

```
# Create and identity for Terraform
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/${SUBSCRIPTION_ID}"
# Your response is going to be like
{
  "appId": "xxxxxxx",
  "displayName": "xxxxxxx",
  "name": "xxxxxx",
  "password": "xxxxx",
  "tenant": "xxxxxx"
}
```

### Edit file
```
vim $HOME/.bashrc
```

### Add variables
```
export ARM_SUBSCRIPTION_ID=${SUBSCRIPTION_ID}
export ARM_CLIENT_ID=<appId>
export ARM_CLIENT_SECRET=password
export ARM_TENANT_ID=tenant
export TF_PLUGIN_CACHE_DIR=$HOME/.terraform.d/plugin-cache
```

### Reload bash
```
source ~/.bashrc
```