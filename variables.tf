variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "name" {
  description = "Base name for the resources"
  type        = string
}

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
}

variable "tags" {
  description = "AWS resources tags"
  type        = map(string)
  default     = {}
}