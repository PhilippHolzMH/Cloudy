variable "public_subnet" {
    type = object({id = string})  
}
variable "public_sg"{
    type = object({id = string})
}
variable "key"{
    type = object({key_name = string})
}
variable "ami" {
    type = string  
}
variable "s3name"{
    type = string
}


resource "aws_instance" "customer_instance" {
    ami                       = var.ami
    instance_type             = "t2.micro"
    vpc_security_group_ids    = [var.public_sg.id]
    subnet_id                 = var.public_subnet.id
    user_data                 = file("./module/public-ec2/user-data.tpl")
    key_name                  = var.key.key_name 
    tags                      = {
        Name = "customer-ec2"
        }
provisioner "local-exec" {
    command = var.s3name
    }
}

resource "aws_eip" "ec2"{
    instance = aws_instance.customer_instance.id
    vpc = true
}

output "ec2id" {
  value = aws_instance.customer_instance.id
}