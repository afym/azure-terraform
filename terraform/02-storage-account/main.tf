provider "azure" {}

variable "location" {
  default = "brazilsouth"
}


resource "azurerm_resource_group" "test_rg" {
  location = "${var.location}"
  name = "custom-development-rg" // <service short name>-<environment>-rg
}

resource "azurerm_storage_account" "test" {
  name                     = "customp0021" // <globally unique name> <number>
  resource_group_name      = "${azurerm_resource_group.test_rg.name}"
  location                 = "${var.location}"
  account_tier             = "Standard" // Standard, Premium
  account_kind             = "StorageV2" // Storage, StorageV2, BlobStorage
  access_tier              = "Hot" // Hot , Cool
  account_replication_type = "LRS" // LRS, GRS, RAGRS and ZRS
  enable_https_traffic_only = true
  enable_blob_encryption   = true

  tags = {
    billTo = "IT"
    manageBy = "afym@github.com"
    projectName = "Terraform demo"
    projectVersion = "1.0.1"
    environment = "Development" // Development, Staging, Production, 
    tier = "Data" // Front End, Back End, Data
    dataProfile = "Public" // Public, Confidential, Restricted, Internal
  }
}