variable "location" {
  description = "Azure region where the resources will be created (e.g., Southeast Asia)"
  type        = string
  default     = "Southeast Asia"
}

variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
  default     = "MD-RG1"
}

variable "vnet_name" {
  description = "Name of the Azure Virtual Network"
  type        = string
  default     = "MD-RG1-VNET1"
}

variable "vnet_cidr" {
  description = "CIDR block for the Virtual Network (e.g., 10.0.0.0/16)"
  type        = string
  default     = "10.0.0.0/16"
}

variable "web_app_name" {
  description = "Name of the Azure Web App"
  type        = string
  default     = "magicdragon"
}

variable "web_app_docker_image" {
  description = "URL of the Docker image for the Azure Web App"
  type        = string
  default     = "https://github.com/JohnLacson/API-PoC.git#Dockerfile1"
}

variable "app_gateway_name" {
  description = "Name of the Azure Application Gateway"
  type        = string
  default     = "MD-AppGateway"
}

variable "acr_name" {
  description = "Name of the Azure Container Registry"
  type        = string
  default     = "azcontainerregistry"
}
