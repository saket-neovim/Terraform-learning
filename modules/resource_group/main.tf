resource "azurerm_resource_group" "this" {
  name     = "${var.environment}-${var.name_prefix}-rg"
  location = var.location

  tags = merge(
    var.tags,
    {
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  )

}