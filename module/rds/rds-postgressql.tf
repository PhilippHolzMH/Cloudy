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
variable "instance_type"{
  type = string
}
variable "db_engine" {
  type = string
}
variable "db_engine_version"{
  type = string
}
variable "identifier"{
  type = string
}

resource "aws_db_subnet_group" "default" {
  name       = "private subnetgroup for rds"
  subnet_ids = var.private_subnet_ids
}

resource "aws_db_instance" "customer_db" {
  identifier             = var.identifier
  instance_class         = var.instance_type
  allocated_storage      = var.hd_size
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  username               = var.user_name
  password               = var.db_password
  vpc_security_group_ids = [var.private_sg.id]
  db_subnet_group_name   = "private subnetgroup for rds"
  skip_final_snapshot    = true
}