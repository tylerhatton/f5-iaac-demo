variable "aws_region" {
  default = "us-west-1"
}

variable "key_pair" {
  default = "desk-key"
}

variable "key_file" {
  default = "keyfile.pem"
}

variable "bigiq_secret_name" {
  type = string
  default = "bigiq-lm"
}
