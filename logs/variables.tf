variable "log_group_name" {
  type        = string
  description = "Name for log group"
  default     = "pantori-default"
}

variable "log_group_retention" {
  type        = number
  description = "Log group retention in days"
  default     = 1
}