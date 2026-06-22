output "resource_group_id" {
  description = "Id of the created resource group"
  value       = azurerm_resource_group.production.id
}

output "vnet_id" {
  description = "Id of the created vnet"
  value       = azurerm_virtual_network.production.id
}

output "subscription_info" {
  description = "output of the subscription info"
  value       = "${data.azurerm_subscription.current.display_name} (${data.azurerm_subscription.current.id})"
}

output "tenant_id" {
  description = "Output of the tenant id"
  value       = data.azurerm_subscription.current.tenant_id
}