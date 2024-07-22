variable "file_name" {
  type        = string
  description = "code file to be executed"
}

variable "function_name" {
  type = string
}

variable "role_arn" {
  type = string
}

variable "handler" {
  type = string
}

variable "runtime" {
  type = string
}

variable "env_vars" {
  type = map(string)
  default = {
    "name"  = "name"
    "value" = "value"
  }
}

variable "is_scheduled" {
  type = bool
}

variable "schedule_name" {

}

variable "schedule_expression" {

}

variable "schedule_description" {

}

variable "schedule_target_id" {

}