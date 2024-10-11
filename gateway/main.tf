locals {
  backend_address_pool_name      = "${var.vnet}-beap"
  frontend_port_name             = "${var.vnet}-feport"
  frontend_ip_configuration_name = "${var.vnet}-feipp"
  http_setting_name              = "${var.vnet}-be-htst"
  listener_name                  = "${var.vnet}-httplstn"
  request_routing_rule_name      = "${var.vnet}-rqrt"
  redirect_configuration_name    = "${var.vnet}-rdrcfg"

   # Define the CIDR block
  cidr_block = cidrhost(var.main_cidr, 0)   # Network address
  broadcast_ip = cidrhost(var.main_cidr, -1)  # Broadcast address
  
  # Calculate the number of usable hosts in the /25 subnet (2^7 - 2 usable addresses)
  usable_ips = [
    for i in range(1, 126) : cidrhost(var.main_cidr, i)
    if cidrhost(var.main_cidr, i) != local.cidr_block && cidrhost(var.main_cidr, i) != local.broadcast_ip
  ]
}






resource "azurerm_application_gateway" "appgtw" {
  name                = format("%s-%s", var.prefix, "appgtw")
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location

  
  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 1
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = var.gateway_subnet_id
  }


  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name      = local.frontend_ip_configuration_name
    public_ip_address_id = var.gateway_ip
  }
  
  backend_address_pool {
    name         = local.backend_address_pool_name
    ip_addresses = local.usable_ips

   
    
    
}

#   probe {
#     host                = azurerm_container_app.main.latest_revision_fqdn
#     name                = "probe"
#     protocol            = "Http"
#     path                = "/"
#     interval            = 30
#     timeout             = 30
#     unhealthy_threshold = 3

#     match {
#       status_code = ["200"]
#     }

#   }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
   
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }

#   ssl_certificate {
#     name     = var.domain_name
#     data     = acme_certificate.certificate.certificate_p12
#     password = acme_certificate.certificate.certificate_p12_password
#   }



}