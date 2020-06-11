variable "AMI" {
  type = map(string)
  default = {
    us-east-1 = "ami-0763a836ff06bd7f3"
    us-east-2 = "ami-0e96c75ff14351651"
    us-west-1 = "ami-03bb214db8465d0f8"
    us-west-2 = "ami-07a6d665ac1495bfd"
  }
}

variable "aws_region" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "key_pair" {
  type = string
}

variable "mgmt_subnet_id" {
  type = string
}

variable "external_subnet_id" {
  type = string
}

variable "internal_subnet_id" {
  type = string
}

variable "bigiq_secret_name" {
  type = string
}

variable "external_ips" {
  type = list
}

variable "internal_self_ip" {
  type = string
}

variable "management_ip" {
  type = string
}

variable "default_tags" {
  type = map
  default = {}
}

variable "name_prefix" {
  default = ""
}