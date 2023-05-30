variable "availability_zone" {
  type        = string
  description = "Set aws availability zone"
  default     = "us-east-1b"
}

variable "volume_size" {
  type        = number
  description = "Set volume size"
  default     = "2"
}

variable "maintainer" {
  type        = string
  description = "Set maintainer"
  default     = "Xzo"
}

