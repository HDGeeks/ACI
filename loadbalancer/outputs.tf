

output "public_ip" {
  description = "The public IP address of the load balancer."
  value       = azurerm_public_ip.load_balancer_ip.ip_address
}

output "load_balancer_id" {
  description = "The ID of the load balancer."
  value       = azurerm_lb.demo_load_balancer.id
}

output "backend_address_pool_id" {
  description = "The ID of the backend address pool."
  value       = azurerm_lb_backend_address_pool.target-groups.id
}
output "backend_address_pool_name" {
  description = "The ID of the backend address pool."
  value       = azurerm_lb_backend_address_pool.target-groups.name
}

output "http_probe_id" {
  description = "The ID of the HTTP probe."
  value       = azurerm_lb_probe.http_probe.id
}

# output "https_rule_id" {
#   description = "The ID of the HTTPS load balancer rule."
#   value       = azurerm_lb_rule.https.id
# }

output "http_rule_id" {
  description = "The ID of the HTTP load balancer rule."
  value       = azurerm_lb_rule.http.id
}


output "full_dns_label" {
  value = "${var.domain_name_label}.germanywestcentral.cloudapp.azure.com"
}

//lbcgidemo12.germanywestcentral.cloudapp.azure.com