provider "azure" {}

variable "location" {
  default = "centralus"
}

resource "azurerm_resource_group" "test" {
  name     = "app-dev-rg" // 
  location = "${var.location}"
}

resource "azurerm_virtual_network" "test" {
  name                = "app-vnet" // <service short name>-vnet
  location            = "${azurerm_resource_group.test.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"
  address_space       = ["192.168.0.0/16"]

  subnet {
    name           = "frontend-sn" // <descriptive context>
    address_prefix = "192.168.1.0/24" // 251
    security_group = "${azurerm_network_security_group.frontend.id}"
  }

  subnet {
    name           = "backend-sn" // <descriptive context>
    address_prefix = "192.168.2.0/24" // 251
    security_group = "${azurerm_network_security_group.backend.id}"
  }

  subnet {
    name           = "data-sn" // <descriptive context>
    address_prefix = "192.168.3.0/24" // 251
    security_group = "${azurerm_network_security_group.data.id}"
  }

  tags = {
    environment = "Production"
  }
}

resource "azurerm_network_security_group" "frontend" {
  name                = "frontend-sg"
  location            = "${azurerm_resource_group.test.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"

  security_rule {
    name                       = "frontend-allow-https"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

    tags = {
        application = "vnets"
  }
}

resource "azurerm_network_security_group" "backend" {
  name                = "backend-sg"
  location            = "${azurerm_resource_group.test.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"
}

resource "azurerm_network_security_group" "data" {
  name                = "data-sg"
  location            = "${azurerm_resource_group.test.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"
}
