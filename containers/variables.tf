variable "container_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "acr_login_server" {
  type = string
}

variable "identity_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "image" {
  type        = string
  description = "Container image to deploy. Should be of the form repoName/imagename:tag for images stored in public Docker Hub, or a fully qualified URI for other registries. Images from private registries require additional registry credentials."
  default     = "mcr.microsoft.com/azuredocs/aci-helloworld"
}

variable "restart_policy" {
  type        = string
  description = "The behavior of Azure runtime if container has stopped."
  default     = "Always"
  validation {
    condition     = contains(["Always", "Never", "OnFailure"], var.restart_policy)
    error_message = "The restart_policy must be one of the following: Always, Never, OnFailure."
  }
}

variable "network_profile_id" {
  type = string
  
}


variable "virtual_network_id" {
  description = "The ID of the virtual network."
  type        = string
}

variable "container_image" {
  description = "The Docker image to be pulled from ACR."
  type        = string
  default     = "web-app:latest"  # Set your default image here
}

variable "acr_server" {
  description = "The login server for the Azure Container Registry."
  type        = string
  
}
