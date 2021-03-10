#------------VPC-------------
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  enable_dns_support = "true"

  tags = {
    Name = var.vpc_name
  }
}
################PUBLIC SUBNET#################
#-------------IGW---------------
resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "practice_02"
  }
}
#------------subnet-------------
resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"

  availability_zone = var.az[0]

  map_public_ip_on_launch = true

  tags = {
    "Name" = "public_subnet"
  }
}
#------------association-------------
resource "aws_route_table_association" "association1" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
#------------router table------------
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }

  tags = {
    "Name" = "public_table"
  }
}
################PRIVATE SUBNET#################
#-------------subnet-------------
resource "aws_subnet" "private" {
  vpc_id = aws_vpc.main.id

  availability_zone = var.az[0]

  cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "private2" {
  vpc_id = aws_vpc.main.id

  availability_zone = var.az[1]

  cidr_block = "10.0.2.0/24"
}
