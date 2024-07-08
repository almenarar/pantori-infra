variable "name" {
  type        = string
  description = "Repository name"
  default     = "pantori-default"
}

variable "tags" {
  type        = map(string)
  description = "Repository tags"
  default = {
    "Environment" = "default"
    "Name"        = "default"
    "Onwer"       = "pantori-default"
  }
}