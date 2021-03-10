variable "aws_region" {
  description = "region for AWS"
}

variable "vpc_name" {
  description = "name for practice_02 VPC"
}

variable "subnet_name" {
}

variable "instance_names" {
  type = list(string)
}

variable "az" {
  type    = list(string)
  default = ["ap-northeast-2a"]
}

variable "ami_id_maps" {
  type    = map(any)
  default = {}
}

variable "instance_type" {
}
