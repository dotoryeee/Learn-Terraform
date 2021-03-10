aws_region = "ap-northeast-2"

vpc_name = "vpc_practice_02"

subnet_name = "subnet_practice_02"

az = [
    "ap-northeast-2a", 
    "ap-northeast-2c"
]

instance_names = [
    "public-01", 
    "public-02"
]

ami_id_maps = {
    amazon_linux_2 = "ami-006e2f9fa7597680a"
    ubuntu_20_04 = "ami-00f1068284b9eca92"
}

instance_type = "t2.micro"