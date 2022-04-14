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
    command = "aws s3api create-bucket --bucket customer-upload-bucket12 --region us-west-2 --create-bucket-configuration LocationConstraint=us-west-2"
    }
}

resource "aws_eip" "ec2"{
    instance = aws_instance.customer_instance.id
    vpc = true
}