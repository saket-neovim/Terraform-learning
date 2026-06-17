resource "azurerm_resource_group" "main" {
  name     = "terraform-course"
  location = var.location
  tags = {
    name        = "terraform-course"
    environment = var.environment
    managed_by  = "Terraform"
  }
}

resource "azurerm_virtual_network" "main" {
  name                = "terraform-network"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  address_space       = var.vnet_address_space

  tags = {
    name        = "terraform-course"
    environment = var.environment
    managed_by  = "Terraform"
  }
}

resource "azurerm_subnet" "web" {
  name                 = "web-subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.web_subnet_cidr]
}

resource "azurerm_subnet" "app" {
  name                 = "app-subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.app_subnet_cidr]
}

#Network Security Groups
resource "azurerm_network_security_group" "web" {
  name                = "web-nsg"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  tags = {
    name        = "web-nsg"
    environment = var.environment
  }
}

resource "azurerm_network_security_group" "app" {
  name                = "app-nsg"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  tags = {
    name        = "app-nsg"
    environment = var.environment
  }
}

resource "azurerm_network_security_rule" "web_http" {
  name                        = "Allow_HTTP"
  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.web.name
  protocol                    = "Tcp"
  access                      = "Allow"
  priority                    = 100
  direction                   = "Inbound"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
}

resource "azurerm_network_security_rule" "web_https" {
  name                        = "Allow_HTTPS"
  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.web.name
  protocol                    = "Tcp"
  access                      = "Allow"
  priority                    = 110
  direction                   = "Inbound"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
}

resource "azurerm_network_security_rule" "app_internal" {
  name                        = "allow_internal"
  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.app.name
  protocol                    = "Tcp"
  access                      = "Allow"
  priority                    = 100
  direction                   = "Inbound"
  source_port_range           = "*"
  destination_port_range      = "8080"
  source_address_prefix       = var.web_subnet_cidr
  destination_address_prefix  = "*"
}

resource "azurerm_subnet_network_security_group_association" "web" {
  subnet_id                 = azurerm_subnet.web.id
  network_security_group_id = azurerm_network_security_group.web.id

}