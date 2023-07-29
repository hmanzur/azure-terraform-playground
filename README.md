# My First Azure Terraform App

[![Build Status](https://dev.azure.com/habibmanzur/PandaClub/_apis/build/status%2Fhmanzur.azure-terraform-playground?branchName=main)](https://dev.azure.com/habibmanzur/PandaClub/_build/latest?definitionId=3&branchName=main)

Setup backend configuration https://learn.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?tabs=azure-cli

## Create a Service Principal

https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret

## Commands

### Init

Install providers and setup backend configuration

```console
terraform init
```

### Validate

Validate local code

```console
terraform validate
```

### Format

Stylish the code. Use the `-recursive` flag if you want to apply dir in deep

```console
terraform fmt 
```

### Plan

Create an schema of changes to be applied

```console
terraform plan 
```

### Apply

Apply changes from source code. Use the `-auto-approve` if want to avoid manual confirmation.

```console
terraform apply 
```