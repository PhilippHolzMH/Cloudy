variable "private_subnet_ids" {
  type = list(string) 
}
variable "private_sg"{
  type = object({id = string})
}
variable "db_password" {
  type = string
}
variable "user_name" {
  type = string
}
variable "hd_size" {
  type = string
}

resource "aws_db_subnet_group" "default" {
  name       = "private subnetgroup for rds"
  subnet_ids = var.private_subnet_ids
}

resource "aws_db_instance" "customer_db" {
  identifier             = "customer"
  instance_class         = "db.t3.micro"
  allocated_storage      = var.hd_size
  engine                 = "postgres"
  engine_version         = "13.4"
  username               = var.user_name
  password               = var.db_password
  vpc_security_group_ids = [var.private_sg.id]
  db_subnet_group_name   = "private subnetgroup for rds"
  skip_final_snapshot    = true
}