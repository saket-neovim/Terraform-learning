output "resource_group_id" {
  description = "id of the resource group"
  value       = azurerm_resource_group.this.id

}

output "resource_group_name" {
  description = "name of the resource group"
  value       = azurerm_resource_group.this.name

}

output "resource_group_location" {
  description = "Location of the resource group"
  value       = azurerm_resource_group.this.location
}