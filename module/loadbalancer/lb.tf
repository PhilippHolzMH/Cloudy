variable "public_sub1" {
    type = object({id = string})
}
variable "public_sub2" {
    type = object({id = string})
}
variable "public_sg"{
    type = object({id = string})
}
variable "instanceid"{
    type = string
}
variable "lb_tg_arn"{
    type = string
}


resource "aws_lb" "customer_lb" {
  name               = "customer-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.public_sg.id]
  subnets            = [var.public_sub1.id,var.public_sub2.id]

  enable_deletion_protection = true
  idle_timeout                = 400

  tags = {
    Name = "customer-elb"
  }
}


resource "aws_lb_target_group_attachment" "lb_targetgroup_attachment" {
  target_group_arn = var.lb_tg_arn
  target_id        = var.instanceid
  port             = 80
}
resource "aws_lb_listener" "ops_alb_listener_8080" {
  load_balancer_arn = aws_lb.customer_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = var.lb_tg_arn
    type             = "forward"
  }
}

