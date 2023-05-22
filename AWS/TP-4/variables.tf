variable "instance_type" {
  type        = string
  description = "Set aws instance type"
  default     = "t2.nano"
}

variable "aws_common_tag" {
  type        = map(any)
  description = "Set aws tag"
  default = {
    Name : "ec2-xzo"
  }
}

variable "key_name" {
  type        = string
  description = "Set aws key name"
  default     = "devops-xzo"
}