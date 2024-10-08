
resource "azurerm_public_ip" "load_balancer_ip" {
  name                = "${var.prefix}-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  domain_name_label   = var.domain_name_label
  sku = "Standard"
}

resource "azurerm_lb" "demo_load_balancer" {
  name                = "${var.prefix}-load-balancer"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku = "Standard"

    frontend_ip_configuration {
    name                 = "frontendIPConfiguration"
    //subnet_id            = var.subnet_id 
    public_ip_address_id = azurerm_public_ip.load_balancer_ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "target-groups" {
  loadbalancer_id = azurerm_lb.demo_load_balancer.id
  name            = "target-group-containers"
 
}

resource "azurerm_lb_probe" "http_probe" {
  resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.demo_load_balancer.id
  name                = "http"
  port                = 80
  protocol            = "Http"
  request_path        = "/"
}

resource "azurerm_lb_rule" "http" {
  resource_group_name              = var.resource_group_name
  loadbalancer_id                  = azurerm_lb.demo_load_balancer.id
  name                             = "HTTP"
  protocol                         = "Tcp"
  frontend_port                    = 80
  backend_port                     = 80
  frontend_ip_configuration_name    = "frontendIPConfiguration"
  probe_id                         = azurerm_lb_probe.http_probe.id
  backend_address_pool_ids         = [azurerm_lb_backend_address_pool.target-groups.id]
  disable_outbound_snat            = true
}

# resource "azurerm_lb_rule" "https" {
#   resource_group_name              = var.resource_group_name
#   loadbalancer_id                  = azurerm_lb.demo_load_balancer.id
#   name                             = "HTTPS"
#   protocol                         = "Tcp"
#   frontend_port                    = 443
#   backend_port                     = 80
#   frontend_ip_configuration_name    = "publicFacingLb"
#   probe_id                         = azurerm_lb_probe.http_probe.id
#   backend_address_pool_ids         = [azurerm_lb_backend_address_pool.target-groups.id]
#   disable_outbound_snat            = true
# }
