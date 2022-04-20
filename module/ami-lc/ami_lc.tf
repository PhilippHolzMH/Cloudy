
variable "instanceid"{
    type = string
}
variable "key"{
    type = object({key_name = string})
}
variable "public_sg"{
    type = object({id = string})
}
variable "public_subnet" {
    type = object({id = string})  
}

resource "aws_ami_from_instance" "customer-ami" {
  name               = "customer-ami"

  source_instance_id = var.instanceid  
}
resource "aws_launch_configuration" "customer_lc" {
  name_prefix                       = "customer_lc"
  image_id                          = aws_ami_from_instance.customer-ami.id
  instance_type                     = "t2.micro"
  key_name                          = var.key.key_name
  
  lifecycle {
    create_before_destroy = true
  }

  user_data = filebase64("./module/ami-lc/user-data-ami.tpl")
}
output "template_id" {
  value = aws_launch_configuration.customer_lc.id  
}