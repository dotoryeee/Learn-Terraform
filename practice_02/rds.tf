#--------------Security Group----------------
resource "aws_security_group" "rds" {
  vpc_id = aws_vpc.main.id
  name   = "SG-for-RDS"

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.public_ec2.id]
  }
}
# resource "aws_security_group_rule" "allow_access_db_from_ec2" {
#   type                     = "ingress"
#   from_port                = 3306
#   to_port                  = 3306
#   protocol                 = "tcp"
#   security_group_id        = aws_security_group.rds.id
#   source_security_group_id =
# }
##---------------RDS Subnet Group--------
resource "aws_db_subnet_group" "_" {
  name = "subnet_for_rds"
  subnet_ids = [
    aws_subnet.private.id,
    aws_subnet.private2.id
  ]
}
#----------------RDS instance-------------
resource "aws_db_instance" "_" {
  #settings for Free tier
  instance_class      = "db.t2.micro"
  skip_final_snapshot = true
  allocated_storage   = 10
  engine              = "mysql"
  engine_version      = "5.7"
  #settings for Free tier

  identifier = "demodb"
  username   = "root"
  password   = "password"
  name       = "mydb"

  db_subnet_group_name = aws_db_subnet_group._.name

  vpc_security_group_ids = [aws_security_group.rds.id]
}
