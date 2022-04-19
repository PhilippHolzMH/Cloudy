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
}

resource "aws_vpc" "main" {
  cidr_block = var.cidrblock
}
output "elb_tg_arn"{
    value = aws_lb_target_group.lb_target.arn
}