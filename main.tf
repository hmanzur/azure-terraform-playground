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

# FRONTEND
resource "azurerm_service_plan" "frontend" {
  count               = var.enable_webapp ? 1 : 0
  name                = "Frontend-ServicePlan"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_linux_web_app" "frontend" {
  count               = var.enable_webapp ? 1 : 0
  name                = "habi-panda-webapp"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_service_plan.frontend[count.index].location
  service_plan_id     = azurerm_service_plan.frontend[count.index].id

  site_config {
    application_stack {
      docker_image_name = "appsvc/staticsite:latest"
    }
  }
}
# END FRONTEND

# CONTAINER
resource "azurerm_container_registry" "backend" {
  name                  = "habipandabackendapp"
  resource_group_name   = azurerm_resource_group.main.name
  location              = azurerm_resource_group.main.location
  sku                   = "Standard"
}

resource "azurerm_log_analytics_workspace" "this" {
  name                = "backend-logger"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_container_app_environment" "backend" {
  count                      = var.enable_containerapp ? 1 : 0
  name                       = "Backend-Environment"
  location                   = azurerm_resource_group.main.location
  resource_group_name        = azurerm_resource_group.main.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
}

resource "azurerm_container_app" "backend" {
  count                        = var.enable_containerapp ? 1 : 0
  name                         = "backend-app"
  container_app_environment_id = azurerm_container_app_environment.backend[count.index].id
  resource_group_name          = azurerm_resource_group.main.name
  revision_mode                = "Single"

  template {
    container {
      name   = "backend"
      image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }
  }

  lifecycle {
    ignore_changes = [
      template[0].container[0].image
    ]
  }
}
# END CONTAINER
