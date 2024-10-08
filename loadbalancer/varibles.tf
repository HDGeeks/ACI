
variable "location" {
  description = "The Azure location where the resources will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "prefix" {
  description = "A prefix to be used for resource names."
  type        = string
}

variable "subnet_id" {
    type = string
  
}
variable "domain_name_label" {
    type = string
    default = "lbcgidemo12"
  
}