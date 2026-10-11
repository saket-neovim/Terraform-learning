
resource "azurerm_resource_group" "main" {
  name     = "${var.prefix}-rg"
  location = var.azure_location

  tags = {
    Name        = "${var.prefix}-rg"
    Environment = var.environment
    Lab         = var.lab_name
  }

}

import {
  to = azurerm_virtual_network.main
  id = var.import_vnet_id

}

resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-vnet"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  address_space       = [var.vnet_cidr]

  tags = {
    Name        = "${var.prefix}-vnet"
    Environment = var.environment
    Lab         = var.lab_name
  }

}

import {
  to = azurerm_subnet.app
  id = var.import_subnet_id

}

resource "azurerm_subnet" "app" {
  name                 = "${var.prefix}-subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.subnet_cidr]

}

import {
  to = azurerm_network_security_group.main
  id = var.import_nsg_id
}

resource "azurerm_network_security_group" "main" {
  location            = azurerm_resource_group.main.location
  name                = "${var.prefix}-nsg"
  resource_group_name = azurerm_resource_group.main.name
  tags = {
    Environment = var.environment
    Lab         = var.lab_name
    Name        = "${var.prefix}-nsg"
  }
}
