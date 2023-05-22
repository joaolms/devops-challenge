variable "network_cidr" {
  description = "CIDR network"
  type        = string
}

variable "n_subnets" {
  description = "Numbers of subnet to be create"
  type        = number
  validation {
    error_message = "The number of subnets must be 4, 5 or 6."
    condition     = min(var.n_subnets) >= 4 && max(var.n_subnets) <= 6
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
