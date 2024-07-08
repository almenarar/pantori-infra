variable "service_name" {
  type        = string
  description = "Service name"
  default     = "pantori-default"
}

variable "cluster" {
  type        = string
  description = "ECS cluster to include the service"
  default     = "pantori-default"
}

variable "role_arn" {
  type = string
}

variable "container_count" {
  type        = number
  description = "Number of desired containers"
  default     = 1
}

variable "cpu" {
  type        = string
  description = "Amount of CPU per container"
  default     = "256"
}

variable "memory" {
  type        = string
  description = "Amount of memory per container"
  default     = "512"
}

variable "image_name" {
  type        = string
  description = "Container image name"
  default     = "pantori-default"
}

variable "port" {
  type        = number
  description = "Container/Host port to open"
  default     = 80
}

variable "environment_variables" {
  type        = list(map(string))
  description = "Environment variables for the container, don`t include sensible data here"
  default = [{
    "name"  = "name"
    "value" = "value"
  }]
}

variable "has_secrets" {
  type    = bool
  default = false

}

variable "secrets" {
  type        = list(map(string))
  description = "Sensible environment variables for the container"
}

variable "log_group_name" {

}

variable "is_web_faced" {
  type        = bool
  default     = false
  description = "Set true to create a loadbalance with public endpoint"
}

variable "vpc" {

}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "security_group_ecs" {

}

variable "security_group_alb" {

}