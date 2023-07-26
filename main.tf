// https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "${var.owner}-resourcegroup"
  location = var.location
}

resource "azurerm_storage_account" "panda" {
  name                     = replace("${var.owner}storage", "-", "")
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

/* resource "azurerm_storage_container" "default" {
  name                  = "${var.owner}-container"
  storage_account_name  = azurerm_storage_account.panda.name
  container_access_type = "private"
} */