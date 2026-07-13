variable "resource_group_name" {
  description = "Name of the resource group where the subnet will be created"
  type        = string
}

variable "virtual_network_name" {
  description = "Name of the virtual network where the subnet will be created"
  type        = string
}

variable "subnet_cidr" {
  description = "Address prefix for the subnet"
  type        = string
}

variable "prefix" {
  description = "Prefix for resource names"
  type        = string
}

resource "azurerm_subnet" "app" {
  name                 = "${var.prefix}-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = [var.subnet_cidr]
}