variable "private_subnet" {
    type = object({id = string})  
}
variable "private_sg"{
    type = object({id = string})
}

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [var.private_subnet.id]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "customer_db" {
  identifier             = "customer"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  engine                 = "postgres"
  engine_version         = "13.4"
  username               = "admin"
  password               = "testpassword"
  vpc_security_group_ids = [var.private_sg.id]
  db_subnet_group_name   = "default"
  skip_final_snapshot    = true
}