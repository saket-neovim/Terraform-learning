resource "azurerm_resource_group" "example" {
  name     = "rg-${var.environment}-modules"
  location = var.location

  tags = {
    Environment = var.environment
    Terraform   = "true"
  }

}

module "vnet" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "0.19.0"

  parent_id = azurerm_resource_group.example.id

  # Basic VNet configuration
  enable_telemetry = false
  name             = "vnet-main-${random_string.suffix.result}"
  address_space    = ["10.0.0.0/16"]
  location         = var.location

  subnets = {
    for key, value in var.subnets : key => {
      name             = "snet-${key}"
      address_prefixes = [value]
    }
  }

  tags = {
    Terraform   = "true"
    Environment = var.environment
    ModuleDemo  = "true"
    Owner       = "Amaan"
  }

}

resource "random_string" "suffix" {
  length  = 5
  special = false
  upper   = true
}
