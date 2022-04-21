
variable "template_id"{
    type = string
}
variable "public_sub1" {
    type = object({id = string})
}
variable "public_sub2" {
    type = object({id = string})
}
variable "desired_capacity" {
  type = number  
}
variable "max_size"{
  type = number
}
variable "min_size"{
  type = number
}

resource "aws_autoscaling_group" "customer_asg" {
  desired_capacity      = var.desired_capacity
  max_size              = var.max_size
  min_size              = var.min_size
  launch_configuration  = var.template_id
  vpc_zone_identifier   = [var.public_sub1.id,var.public_sub2.id]
}

