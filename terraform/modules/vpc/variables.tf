variable "name_prefix" {
  default = ""
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "external_net_cidr" {
  default = "10.0.1.0/24"
}

variable "internal_net_cidr" {
  default = "10.0.2.0/24"
}

variable "management_net_cidr" {
  default = "10.0.3.0/24"
}