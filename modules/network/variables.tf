variable "environment" {
  description = "Type of environment"
  type        = string
  default     = "demo"
}

variable "network_cidr" {
  description = "CIDR network"
  type        = string
}

variable "n_subnets" {
  description = "Numbers of subnet to be create"
  type        = number
  validation {
    error_message = "The number of subnets must be greater than or equal to 2 and less than or equal to 6."
    condition = min(var.n_subnets)>=2 && max(var.n_subnets)<=6
  }
}

variable "name" {
  description = "Resource name"
  type        = string
}

variable "tags" {
  description = "AWS resources tags"
  type        = map(string)
  default     = {}
}
