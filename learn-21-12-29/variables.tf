##############################################################################
# Variables File
#
# Here is where we store the default values for all the variables used in our
# Terraform code. If you create a variable with no default, the user will be
# prompted to enter it (or define it via config file or command line flags.)

# Uncomment the lines below to get started declaring your variables

variable "prefix" {
  description = "This prefix will be included in the name of most resources."
  default     = "tflabs"
}

variable "environment" {
  default = "development"
}

variable "region" {
  # Follow the example above to declare this variable
  # Set both a description and default value
  default = "us-east-1"
}

variable "vpc_cidr" {
  # Follow the example above to declare this variable
  # Set both a description and default value
  default = "192.16.0.0/24"
}

variable "subnet_cidr" {
  # Follow the example above to declare this variable
  # Set both a description and default value
  default = "192.16.0.0/24"
}
