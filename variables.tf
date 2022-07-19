variable "clientid" {
  description = "Azure Client ID Password"
  type        = string
  sensitive   = true
}

variable "clientsecret" {
  description = "Azure Client Service Principal Secret Password"
  type        = string
  sensitive   = true
}

variable "subscriptionid" {
  description = "Azure Subscription ID Password"
  type        = string
  sensitive   = true
}

variable "tenantid" {
  description = "Azure Tenant ID Password"
  type        = string
  sensitive   = true
}

variable "testpassword" {
  description = "Generic Global Test Password"
  type        = string
  sensitive   = true
}

variable "container" {
  description = "container tag"
  type        = string
}

variable "networkpart" {
  description = "network part of vnet"
  type        = string
}
