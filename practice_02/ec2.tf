#----------------SG---------------------
resource "aws_security_group" "public_ec2" {
  vpc_id = aws_vpc.main.id

  name        = "allow SSH"
  description = "allow SSH from anywhere"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "SG-for-publicEC2"
  }
}
#-------------Key pair--------------
resource "aws_key_pair" "dotoryeee" {
  key_name   = "dotoryeee"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDD5D5mHSD/vdgcGmh6Kd57DqLxebcvbrUsHj8DYDW0+9MSvvK874Bm4hpqHliYze/ht7VnzL5+A5qZkCevKGBDeJNmR/QDHccCsCfRuyEmzMlvj3SxzYSH2N4lBG6eZZbQ+0yRl7ny3aeyol5boDkztLZ/PZwVR5IH6BgsNiGClSDtuf2CYoKN7hQufjeuCDcLlQa+ItFa4abMe/mWtMeEh7+ZpC+0KAFFvqY80OCtuUdqq7tcP8uHzQy9mPKvKBieJYitUoStjFEMAro1v34u6193Qgk6DAhyMom4GmLc2+tTyKMsvBlRKUOb87F+2zsATX3Ahz9cMpEkfPTkY15V dotoryeee@i5-6500"
}
#----------------EC2---------------------
resource "aws_instance" "public_01" {
  ami           = var.ami_id_maps["amazon_linux_2"]
  instance_type = var.instance_type

  subnet_id = aws_subnet.public.id

  security_groups = [aws_security_group.public_ec2.id]

  key_name = aws_key_pair.dotoryeee.key_name

  tags = {
    Name = var.instance_names[0]
  }
}


resource "aws_instance" "public_02" {
  ami           = var.ami_id_maps["ubuntu_20_04"]
  instance_type = var.instance_type

  subnet_id = aws_subnet.public.id

  security_groups = [aws_security_group.public_ec2.id]

  key_name = aws_key_pair.dotoryeee.key_name

  tags = {
    Name = var.instance_names[1]
  }
}
