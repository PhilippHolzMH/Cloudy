variable "private_subnet_ids" {
    type = list(string) 
}

variable "private_sg"{
    type = object({id = string})
}

resource "aws_db_subnet_group" "default" {
  name       = "private subnetgroup for rds"
  subnet_ids = var.private_subnet_list
}

resource "aws_db_instance" "customer_db" {
  identifier             = "customer"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  engine                 = "postgres"
  engine_version         = "13.4"
  username               = "postgress"
  password               = "testpassword"
  vpc_security_group_ids = [var.private_sg.id]
  db_subnet_group_name   = "private subnetgroup for rds"
  skip_final_snapshot    = true
}