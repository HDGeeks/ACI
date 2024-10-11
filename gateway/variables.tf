
variable "email_address" {
  type = string
  default = "dannyhd88@gmail.com"
  
}

variable "domain_name" {
  type = string
  default = "cgidemo.com"
  
}

variable "cert_password" {
  type = string
  default = "password"
  
}

variable "prefix" {
  type = string
  default = "gt"
  
}

variable "vnet" {
  type = string
  
}

variable "resource_group_location" {
    type = string
  
}

variable "resource_group_name" {
    type = string
  
}

variable "gateway_subnet_id" {
  type = string
  
}

variable "gateway_ip" {
  type = string
}



variable "main_cidr" {
  description = "The main CIDR block to flatten into usable IP addresses"
  type        = string
  default     = "10.0.0.0/25"  
}
