variable "location" {
  type    = string
  default = "Central India"
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