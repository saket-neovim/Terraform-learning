output "rg_id" {
  value       = azurerm_resource_group.example.id
  description = "The ID of the parent RG"
}

output "vnet_id" {
  description = "The ID of the basic Virtual Network"
  value       = module.vnet.resource_id
}

output "vnet_name" {
  description = "The name of the basic Virtual Network"
  value       = module.vnet.name
}
