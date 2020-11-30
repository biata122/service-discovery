variable "region" {
  description = "AWS region for VMs"
  default = "us-east-1"
}

variable "key_name" {
  description = "name of ssh key to attach to hosts"
}

variable "ami" {
  description = "ami (ubuntu 18) to use - based on region"
  default = {
    "us-east-1" = "ami-00ddb0e5626798373"
    "us-east-2" = "ami-0dd9f0e7df0f0a138"
  }
}

