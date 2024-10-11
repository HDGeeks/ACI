variable "vnet_name" {
  type = string
  description = "Name of the Virtual Network"
  default = "Demo-Vnet"
}

variable "container_subnet" {
  type = string
  description = "Name of the Subnet"
  default = "containers_subnet"
}

variable "resource_group_name" {
  type = string
}

variable "resource_group_location" {
  type = string
}


variable "domain_name_label" {
  type        = string
  description = "The dns label for the ipv4"
  default     = "cgidemo"
}
