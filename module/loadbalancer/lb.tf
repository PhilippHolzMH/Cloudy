data "aws_subnets" "available" {}
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


resource "aws_elb" "customer_lb" {
    type               = "instance"
    internal           = false
    subnets            = [var.public_subnet.id]
    security_groups    = [var.public_sg.id]


  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }


  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }
    cross_zone_load_balancing   = true
    idle_timeout                = 400
    connection_draining         = true
    connection_draining_timeout = 400

  tags = {
    Name = "customer-elb"
  }
}
resource "aws_elb_attachment" "elb_ec2" {
  elb      = aws_elb.customer_lb.id
  instance = var.instanceid
}
resource "aws_lb_target_group_attachment" "lb_targetgroup_attachment" {
  target_group_arn = var.elb_tg_arn
  target_id        = var.instanceid
  port             = 80
}