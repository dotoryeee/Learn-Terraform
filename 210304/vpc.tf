resource "aws_vpc" "terra-test" {
	cidr_block = "10.0.0.0/16"

	tags = {
		Name = "Terraform TEST1"
	}
}

resource"aws_subnet" "public01" {
	vpc_id = aws_vpc.terra-test.id
	cidr_block = "10.0.0.0/24"
	availability_zone = "ap-northeast-2a"

	tags = {
		Name = "terra-public-01-subnet"
	}
}

resource "aws_subnet" "private01" {
	vpc_id = aws_vpc.terra-test.id
        cidr_block = "10.0.1.0/24"

        tags = {
                Name = "terra-private-01-subnet"
        }
}

resource "aws_internet_gateway" "igw" {
	vpc_id = aws_vpc.terra-test.id
	
	tags = {
		Name = "terra-IGW"
	}
}

resource "aws_eip" "terraEIP" {
	vpc = true

	lifecycle {
		create_before_destroy = true
	}
}

resource "aws_nat_gateway" "nat" {
	allocation_id = aws_eip.terraEIP.id

	subnet_id = aws_subnet.private01.id

	tags = {
		Name = "terra_NAT"
	}
}

