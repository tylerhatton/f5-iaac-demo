variable "AMI" {
  type = map(string)
  default = {
    us-east-1 = ""
    us-east-2 = ""
    us-west-1 = ""
    us-west-2 = ""
  }
}

variable "mgmt_private_ip" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "key_pair" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "name_prefix" {
  type    = string
  default = ""
}

variable "default_username" {
  type    = string
  default = "lab-user"
}

variable "default_tags" {
  type = map
  default = {}
}