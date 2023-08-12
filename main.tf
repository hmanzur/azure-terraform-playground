// https://developer.hashicorp.com/terraform/language/settings/backends/azurerm
terraform {
  backend "azurerm" {
    resource_group_name  = "Terraform-ResourceGroup"
    storage_account_name = "pandatfstates666"
    container_name       = "tfstate"
    key                  = "panda.tfstate"
  }
}

// https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "Panda-ResourceGroup"
  location = var.location
}

resource "azurerm_service_plan" "backend" {
  name                = "Backend-ServicePlan"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_linux_web_app" "backend" {
  name                = "Backend-WebApp"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_service_plan.backend.location
  service_plan_id     = azurerm_service_plan.backend.id

  site_config {
    application_stack {
      docker_image_name = "appsvc/staticsite:latest"
    }
  }
}
