variable "vnet_cidr_blocks" {
  description = "CIDR blocks for virtual networks"
  type        = list(string)
  default     = ["10.0.0.0/16", "10.1.0.0/16", "10.2.0.0/16"]
}

variable "subnet_prefixes" {
  description = "Address prefixes for subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "nsg_names" {
  description = "Names for network security groups"
  type        = list(string)
  default     = ["web", "app", "db"]
}

variable "nsg_ports" {
  description = "Ports for network security groups"
  type        = list(number)
  default     = [80, 8080, 3306]
}

variable "location" {
  description = "Azure region to deploy resources"
  type        = string
  default     = "eastus"
}

variable "vnet_config" {
  description = "Map of vnet configs"
  type        = map(string)
  default = {
    "production"  = "10.0.0.0/16"
    "staging"     = "10.1.0.0/16"
    "development" = "10.2.0.0/16"
  }
}

variable "subnet_config" {
  description = "map of subnet config"
  type        = map(string)
  default = {
    "web" = "10.0.1.0/24"
    "app" = "10.0.2.0/24"
    "db"  = "10.0.3.0/24"
  }
}

variable "nsg_port_map" {
  description = "Map of nsg ports"
  type        = map(string)
  default = {
    "http"  = 80
    "https" = 443
    "app"   = 8080
    "db"    = 3306
  }
}