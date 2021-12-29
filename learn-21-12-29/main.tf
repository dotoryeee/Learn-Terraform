/*
  Providers are going to be configured with different parameters based on the
  resources that it will be configurating.  Below we have an example of what the
  provider resource block would look like for AWS
*/

/*
  AWS provider reference documentation
  https://registry.terraform.io/providers/hashicorp/aws/latest/docs
*/

provider "aws" {
  region = var.region
}

resource "aws_vpc" "tflabs" {
  cidr_block = var.vpc_cidr
  tags = {
    Name        = "${var.prefix}-tflabs"
    environment = var.environment
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.tflabs.id
  cidr_block = var.subnet_cidr

  tags = {
    Name        = "${var.prefix}--subnet"
    environment = var.environment
  }
}

# ------------------------New Code Added Below------------------------------------
# Data Sources are used to fetch information from other
# endpoints, API's, or other terraform configuration.
# Here we are querying AWS for an Ubuntu AMI ID.
# We will use this data sources ID for the EC2 instance below
# "data.aws_ami.ubuntu.id"
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

# Local variables are great for simplyfing expressions
# or to avoid repeating the same values within a configuration.
# A great use-cases is with assinging common tags to all your infrastructure
locals {
  standard_tags = {
    component   = "user-service"
    environment = "development"
  }
}

# This external module encapsulates the VPC/Subnet creation similar to what we did earlier.
# Modules are great for code r/*
  Providers are going to be configured with different parameters based on the
  resources that it will be configurating.  Below we have an example of what the
  provider resource block would look like for AWS
*/

/*
  AWS provider reference documentation
  https://registry.terraform.io/providers/hashicorp/aws/latest/docs
*/

provider "aws" {
  region = var.region
}

resource "aws_vpc" "tflabs" {
  cidr_block = var.vpc_cidr
  tags = {
    Name        = "${var.prefix}-tflabs"
    environment = var.environment
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.tflabs.id
  cidr_block = var.subnet_cidr

  tags = {
    Name        = "${var.prefix}--subnet"
    environment = var.environment
  }
}

# ------------------------New Code Added Below------------------------------------
# Data Sources are used to fetch information from other
# endpoints, API's, or other terraform configuration.
# Here we are querying AWS for an Ubuntu AMI ID.
# We will use this data sources ID for the EC2 instance below
# "data.aws_ami.ubuntu.id"
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

# Local variables are great for simplyfing expressions
# or to avoid repeating the same values within a configuration.
# A great use-cases is with assinging common tags to all your infrastructure
locals {
  standard_tags = {
    component   = "user-service"
    environment = "development"
  }
}

# This external module encapsulates the VPC/Subnet creation similar to what we did earlier.
# Modules are great for code reuse.
module "networking" {
  source = "github.com/hashicorp/terraform-aws-webapp-networking?ref=v1.0.0"
  # Pass the required variables  for the module
  # https://github.com/hashicorp/terraform-aws-webapp-networking/blob/main/variables.tf
  region = var.region
  prefix = var.prefix
  tags   = local.standard_tags

}

# This resources will create an EC2 instance
# Use the following documentation as a guide:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
resource "aws_instance" "tflabs" {
  #Hint: reference the AMI data source ID from above
  ami           = data.aws_ami.ubuntu.image_id
  instance_type = "t3.micro"
  # Hint: https://github.com/hashicorp/terraform-awst-webapp-networking/blob/main/outputs.tf
  subnet_id = aws_subnet.main.id
  tags = {
    # Use a Terraform function to set the created value to a current timestamp
    created = timestamp()
  }
}euse.
module "networking" {
  source = "github.com/hashicorp/terraform-aws-webapp-networking?ref=v1.0.0"
  # Pass the required variables  for the module
  # https://github.com/hashicorp/terraform-aws-webapp-networking/blob/main/variables.tf
  tags = local.standard_tags

}

# This resources will create an EC2 instance
# Use the following documentation as a guide:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
resource "aws_instance" "tflabs" {
  #Hint: reference the AMI data source ID from above
  ami           = data.aws_ami.ubuntu.image_id
  instance_type = "t3.micro"
  # Hint: https://github.com/hashicorp/terraform-awst-webapp-networking/blob/main/outputs.tf
  subnet_id = aws_subnet.main.id
  tags = {
    # Use a Terraform function to set the created value to a current timestamp
    created = timestamp()
  }
}
