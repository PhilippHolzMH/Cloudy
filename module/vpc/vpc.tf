resource "aws_vpc" "customer_vpc" {
    cidr_block = "110.0.0.0/16"
    tags = {
        Name = "customer-vpc"
}
}
resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.customer_vpc.id
}

resource "aws_subnet" "customer_subnet" {
    vpc_id = aws_vpc.customer_vpc.id
    cidr_block = "110.0.0.0/24"
    tags = {
    Name = "customer-subnet"
    map_public_ip_on_launch = true
}
}
resource "aws_route_table" "customer_route_table" {
vpc_id = aws_vpc.customer_vpc.id
tags = {
    Name = "public_route"
}
}
resource "aws_main_route_table_association" "main-table" {
vpc_id         = aws_vpc.customer_vpc.id
route_table_id = aws_route_table.customer_route_table.id
}

resource "aws_route" "prod-route-igw" {
route_table_id            = aws_route_table.customer_route_table.id
destination_cidr_block    = "0.0.0.0/0"
gateway_id                = aws_internet_gateway.gw.id
depends_on                = [aws_route_table.customer_route_table]
}
resource "aws_security_group" "public_sg" {
name        = "public-sg"
description = "Allow the public Subnet to communicate"
vpc_id      = aws_vpc.customer_vpc.id

ingress {
    description      = "SSH to VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
}
ingress {
    description      = "HTTP to VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
}
egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
}
tags = {
    Name = "allow_ssh"
    }  
}

resource "aws_instance" "customer_instance" {
ami                       = "ami-04a50faf2a2ec1901"
instance_type             = "t2.micro"
vpc_security_group_ids    = [aws_security_group.public_sg.id]
subnet_id                 = aws_subnet.customer_subnet.id
user_data                 = file("./user-data.tpl")
tags                      = {
                            Name = "customer-ec2"
                            }
provisioner "local-exec" {
    command = "aws s3api create-bucket --bucket upload-bucket-48191519 --region us-west-1 --create-bucket-configuration LocationConstraint=us-west-1"
    }
}
resource "aws_eip" "ec2"{
    instance = aws_instance.customer_instance.id
    vpc = true
}

