# Resource Group (Deleted)

# Virtual Network (Deleted)

# Subnet (Deleted)

# Route Table (Deleted)

# Network Security Group (Deleted)

# moved {
#   from = azurerm_network_security_group.web
#   to = azurerm_network_security_group.app
# }

# moved {
#   from = module.network.azurerm_subnet.app
#   to   = azurerm_subnet.app
# }

# moved {
#   from = azurerm_subnet.app
#   to   = module.network.azurerm_subnet.app
# }

# removed {
#   from = azurerm_route_table.main

#   lifecycle {
#     destroy = true
#   }
# }

removed {
  from = azurerm_resource_group.main

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_virtual_network.main
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_subnet.app

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_network_security_group.app

  lifecycle {
    destroy = false
  }
}