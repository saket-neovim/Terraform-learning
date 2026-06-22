# Add variables below
variable "environment" {
  description = "Env name for resource naming and tagging"
  type        = string
  default     = "production"
}

variable "location" {
  description = "azure region for resource deployment"
  type        = string
  default     = "eastus"
}

variable "vnet_address_space" {
  description = "address space for virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_prefix" {
  description = "address prefix for subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "project_name" {
  description = "project name for resource tagging"
  type        = string
  default     = "dynamic infrastructure"
}