provider "azurerm" {
}

resource "azurerm_resource_group" "test_rg" {
  location = "Central US"
  name = "AppDevelopmentResourceGroup"
}