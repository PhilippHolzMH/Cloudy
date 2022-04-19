variable "public_subnet" {
    type = object({id = string})
}
variable "public_sg"{
    type = object({id = string})
}
variable "instanceid"{
    type = string
}
variable "elb_tg_arn"{
    type = string
}


resource "aws_lb" "customer_lb" {
  name               = "customer-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.public_sg.id]
  subnets            = [var.public_subnet.id]

  enable_deletion_protection = true
  idle_timeout                = 400

  tags = {
    Name = "customer-elb"
  }
}
resource "aws_elb_attachment" "elb_ec2" {
  elb      = aws_lb.customer_lb.id
  instance = var.instanceid
}
resource "aws_lb_target_group_attachment" "lb_targetgroup_attachment" {
  target_group_arn = var.elb_tg_arn
  target_id        = var.instanceid
  port             = 80
}