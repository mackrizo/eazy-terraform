variable "maintainer" {
  type        = string
  description = "Set maintainer"
  default     = "Xzo"
}

variable "instance_type" {
  type        = string
  description = "Set aws instance type"
  default     = "t2.nano"
}

variable "sg_name" {
  type        = string
  description = "Set sg name"
  default     = "NULL"
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

variable "public_ip" {
  type        = string
  description = "Set public ip"
  default     = "NULL"
}

variable "availability_zone" {
  type        = string
  description = "Set availability zone"
  default     = "us-east-1b"
}

variable "user" {
  type        = string
  description = "Set user name"
  default     = "ubuntu"
}