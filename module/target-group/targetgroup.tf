variable vpcid {
    type = string
}
variable cidrblock {
    type = string   
}

resource "aws_lb_target_group" "lb_target" {
  name     = "customer-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpcid
  health_check {
    path                = "/"
    port                = 80
    protocol            = "HTTP"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = "200-499"
  }
}
resource "aws_vpc" "main" {
  cidr_block = var.cidrblock
}
output "lb_tg_arn"{
    value = aws_lb_target_group.lb_target.arn
}