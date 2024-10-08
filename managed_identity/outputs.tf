output "identity_id" {
  value = azurerm_user_assigned_identity.identity.id
}

output "identity_client_id" {
  value = azurerm_user_assigned_identity.identity.client_id
}

output "identity_principal_id" {
  value = azurerm_user_assigned_identity.identity.principal_id
}
