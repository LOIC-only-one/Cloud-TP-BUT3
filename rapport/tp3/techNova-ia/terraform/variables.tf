variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR block du VPC"
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "Type instance EC2"
}

variable "instance_count" {
  type        = number
  default     = 2
  description = "Nombre d'instances à créer"
  
  validation {
    condition     = var.instance_count > 0 && var.instance_count <= 5
    error_message = "Entre 1 et 5 instances."
  }
}