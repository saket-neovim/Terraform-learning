# Resource Group
resource "azurerm_resource_group" "main" {
  name     = "primary-resources"
  location = "eastus"

  tags = {
    Environment = "Development"
  }
}

# Virtual Networks created with count
resource "azurerm_virtual_network" "vnet_foreach" {
  for_each            = var.vnet_config
  name                = "vnet-count-${each.key}"
  address_space       = [each.value]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  tags = {
    Environment = "Development"
    Network     = "Network-${each.key}"
  }
}

# Subnets created with count
resource "azurerm_subnet" "subnet_foreach" {
  for_each             = var.subnet_config
  name                 = "subnet-count-${each.key}"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.vnet_foreach["production"].name
  address_prefixes     = [each.value]
}

# Network Security Groups created with count
resource "azurerm_network_security_group" "nsg_foreach" {
  for_each            = var.nsg_port_map
  name                = "nsg-${each.key}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  security_rule {
    name                       = "allow-${each.key}"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = each.value
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    Environment = "Development"
    Type        = each.key
  }
}

resource "azurerm_route_table" "rt_foreach" {
  for_each            = var.route_tables
  name                = "rt-${each.key}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  tags = {
    Environment = "Development"
    description = each.value
  }
}