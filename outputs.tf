output "resource_group_id" {
  description = "ID of the created resource group"
  value       = azurerm_resource_group.main.id
}

output "vnet_id" {
  description = "ID of the created Virtual Network"
  value       = azurerm_virtual_network.main.id
}

output "vnet_address_space" {
  description = "address space of the Virtual Network"
  value       = azurerm_virtual_network.main.address_space
}

output "web_subnet_id" {
  description = "ID of the web subnet"
  value       = azurerm_subnet.web.id

}

output "app_subnet_id" {
  description = "ID of the app subnet"
  value       = azurerm_subnet.app.id

}

output "web_nsg_id" {
  description = "Id of the web nsg"
  value       = azurerm_network_security_group.web.id
}

output "app_nsg_id" {
  description = "Id of the app nsg"
  value       = azurerm_network_security_group.app.id
}