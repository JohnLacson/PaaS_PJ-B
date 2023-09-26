provider "azurerm" {
  features {}
}

# Define Azure resource group
resource "azurerm_resource_group" "MD-RG1" {
  name     = var.resource_group_name 
  location = var.location          
}

# Define Azure Virtual Network (VNet)
resource "azurerm_virtual_network" "md_vnet" {
  name                = var.vnet_name             
  location            = var.location              
  resource_group_name = var.resource_group_name 
  address_space       = [var.vnet_cidr]           # CIDR block for the Virtual Network 
 
  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }
}

# Define Azure App Service PLAN
resource "azurerm_service_plan" "md_app_service_plan" {
  name                = "MD-AppServicePlan"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "B1"
  /*
  name                = "MD-AppServicePlan"
  location            = var.location            
  resource_group_name = var.resource_group_name
  kind                = "Linux"
  reserved            = true
  
  sku {
    tier = "Basic"
    size = "B1"
  }
  */

#======== Create a AZ Registry and Image==========
  provisioner "local-exec" {
    command = "az acr create --resource-group MD-RG1 --name mdrgregistry --sku Basic --admin-enabled true"
  }
}


/*
  provisioner "local-exec" {
     command = "az acr build --image magicdragonmain:v1 --registry mdrgregistry --file docker-nginx ."
  }


# Create ACR
resource "azurerm_container_registry" "md_acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"
}
*/

# =============================(Web App)===========================
 /*
resource "azurerm_app_service" "md_web_app" {
  name                = var.web_app_name
  location            = var.location
  resource_group_name = var.resource_group_name #azurerm_resource_group.md_rg.name
  app_service_plan_id = azurerm_service_plan.md_app_service_plan.id
  

resource "azurerm_linux_web_app" "md_web_app" {
  name                = var.web_app_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.md_app_service_plan.id

  site_config {
   # linux_fx_version = "DOCKER|${var.web_app_docker_image}"
   #  linux_fx_version = "DOCKER|https://mdreregistry.azurecr.io/magicdragonmain:v1"
  always_on = true

   application_stack {
    docker_image_name = "mdrgregistry.azurecr.io/magicdragonmain:v1"
    #docker_image_tag = v1
    }
  }
}
*/

/*            -------------------------------------------------

# Define Azure Application Gateway
resource "azurerm_application_gateway" "md_app_gateway" {
  name                = var.app_gateway_name       # Name of the Azure Application Gateway
  location            = var.location               # Location of the Application Gateway
  resource_group_name = azurerm_resource_group.md_rg.name

  sku {
    name     = "Standard_Medium"
    tier     = "Standard"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "gatewayIpConfig"
    subnet_id = azurerm_virtual_network.md_vnet.subnet[0].id
  }

  frontend_port {
    name = "httpPort"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "publicIpAddress"
    public_ip_address_id = azurerm_public_ip.md_public_ip.id
  }

  backend_address_pool {
    name = "backendAddressPool"
    backend_addresses = [azurerm_app_service.md_web_app.default_site_hostname]
  }

  frontend_port {
    name = "frontendPort"
    port = 80
  }

  http_listener {
    name                  = "httpListener"
    frontend_ip_configuration_name = "publicIpAddress"
    frontend_port_name     = "httpPort"
  }

  request_routing_rule {
    name                       = "rule1"
    rule_type                  = "Basic"
    http_listener_name         = azurerm_application_gateway.md_app_gateway.http_listener[0].name
    backend_address_pool_name  = azurerm_application_gateway.md_app_gateway.backend_address_pool[0].name
    backend_http_settings_name = azurerm_application_gateway.md_app_gateway.backend_http_settings[0].name
  }
}



 -----------------------------------------------*/
 