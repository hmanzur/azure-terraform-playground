variable "location" {
  type    = string
  default = "West US"
}

variable "owner" {
  type    = string
  default = "habi-panda"
}

variable "enable_webapp" {
  type        = bool
  default     = false
  description = "Create frontend application"
}

variable "enable_containerapp" {
  type        = bool
  default     = true
  description = "Create containered application"
}

variable "postgresql_connection" {
  type      = string
  default   = ""
  sensitive = true
}

variable "jwt_secret_key" {
  type      = string
  default   = "EMY39QNrkq8mkDExz4Y2gDNjNPeuAJYN"
  sensitive = true
}