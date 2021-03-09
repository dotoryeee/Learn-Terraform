#---------------VPC-----------------
resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default" #전용인스턴스 사용, default는 사용 하지 않음을 의미
    enable_dns_hostnames = true

    tags = {
        Name = "vpc_practice_01"
    }
}
#---------------IGW-----------------
resource "aws_internet_gateway" "default" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "igw_practice_01"
    }
}
#---------------Subnet-----------------
resource "aws_subnet" "public_01" {
    vpc_id = aws_vpc.main.id

    cidr_block = "10.0.0.0/24"
    availability_zone = "ap-northeast-2a"

    map_public_ip_on_launch = true

    tags = {
        Name = "public_subnet_01"
    }
}
resource "aws_subnet" "public_02" {
    vpc_id = aws_vpc.main.id

    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-northeast-2c"

    map_public_ip_on_launch = true

    tags = {
        Name = "public_subnet_02"
    }
}
#--------------Association--------------
resource "aws_route_table_association" "public_01_association" {
    subnet_id = aws_subnet.public_01.id
    route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_02_association" {
    subnet_id = aws_subnet.public_02.id
    route_table_id = aws_route_table.public.id
}
#-------------Route table---------------
resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "public_route_table"
    }
}
#-----------Route table Routes------------
resource "aws_route" "public_sub_IGW" {
    route_table_id = aws_route_table.public.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
}
#----------Security Group for EC2----------
resource "aws_security_group" "practice_01" {
    vpc_id = aws_vpc.main.id
    name = "practice_01_SG"
    description = "SG_for_EC2"

    #-----------인바운드-----------
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "open SSH from Anywhere"
    }

    #----------아웃바운드-----------
    egress {
        from_port = 0 #모든 포트
        to_port = 0 
        protocol = "-1" #모든 프로토콜
        cidr_blocks = ["0.0.0.0/0"] #리스트 형태도 가능
        description = "open all port from anywhere"
    }
}
#----------ready Public Key--------------
resource "aws_key_pair" "practice_01" {
    key_name = "practice_01"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDD5D5mHSD/vdgcGmh6Kd57DqLxebcvbrUsHj8DYDW0+9MSvvK874Bm4hpqHliYze/ht7VnzL5+A5qZkCevKGBDeJNmR/QDHccCsCfRuyEmzMlvj3SxzYSH2N4lBG6eZZbQ+0yRl7ny3aeyol5boDkztLZ/PZwVR5IH6BgsNiGClSDtuf2CYoKN7hQufjeuCDcLlQa+ItFa4abMe/mWtMeEh7+ZpC+0KAFFvqY80OCtuUdqq7tcP8uHzQy9mPKvKBieJYitUoStjFEMAro1v34u6193Qgk6DAhyMom4GmLc2+tTyKMsvBlRKUOb87F+2zsATX3Ahz9cMpEkfPTkY15V dotoryeee@i5-6500"
}
#---------public_01  EC2 Instance---------
resource "aws_instance" "dotoryeee-EC2-01" {
    ami = "ami-006e2f9fa7597680a"
    instance_type = "t2.micro"
    
    subnet_id = aws_subnet.public_01.id

    key_name = aws_key_pair.practice_01.key_name

    security_groups = [aws_security_group.practice_01.id]

    tags = {
        Name = "doto_EC2_01"
    }
}
#---------public_02  EC2 Instance---------
resource "aws_instance" "dotoryeee-EC2-02" {
    ami = "ami-006e2f9fa7597680a"
    instance_type = "t2.micro"

    subnet_id = aws_subnet.public_02.id

    key_name = aws_key_pair.practice_01.key_name

    security_groups = [aws_security_group.practice_01.id]

    tags = {
        Name = "doto_EC2_02"
    }
}