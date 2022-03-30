variable "public_subnet" {
    type = object({id = string})  
}
variable "public_sg"{
    type = object({id = string})
}

resource "aws_instance" "customer_instance" {
ami                       = "ami-04a50faf2a2ec1901"
instance_type             = "t2.micro"
vpc_security_group_ids    = [var.public_sg.id]
subnet_id                 = var.public_subnet.id
user_data                 = file("./user-data.tpl")
tags                      = {
                            Name = "customer-ec2"
                            }
provisioner "local-exec" {
    command = "aws s3api create-bucket --bucket upload-bucket-48916516 --region us-west-1 --create-bucket-configuration LocationConstraint=us-west-1"
    }
}

resource "aws_eip" "ec2"{
    instance = aws_instance.customer_instance.id
    vpc = true
}