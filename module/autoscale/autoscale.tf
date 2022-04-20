
variable "template_id"{
    type = string
}
variable "public_sub1" {
    type = object({id = string})
}
variable "public_sub2" {
    type = object({id = string})
}

resource "aws_autoscaling_group" "customer_asg" {
  desired_capacity      = 6
  max_size              = 6
  min_size              = 1
  launch_configuration  = var.template_id
  vpc_zone_identifier   = [var.public_sub1.id,var.public_sub2.id]
}

