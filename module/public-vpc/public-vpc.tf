data "aws_availability_zones" "available" {}


resource "aws_vpc" "customer_vpc" {
    cidr_block = "54.0.0.0/16"
    enable_dns_hostnames = true
    tags = {
        Name = "customer-vpc"
}
}

resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.customer_vpc.id
}


resource "aws_subnet" "customer_subnet" {
    count                   = "${length(data.aws_availability_zones.available.names)}"
    vpc_id                  = aws_vpc.customer_vpc.id
    cidr_block              = "54.0.${1+count.index}.0/24"
    availability_zone       = "${data.aws_availability_zones.available.names[count.index]}"
    map_public_ip_on_launch = true
    tags = {
        Name = "customer-public-subnet"
    }
}

resource "aws_subnet" "private_subnet" {
    count = "${length(data.aws_availability_zones.available.names)}"
    vpc_id = aws_vpc.customer_vpc.id
    cidr_block = "54.0.${30+count.index}.0/24"
    availability_zone= "${data.aws_availability_zones.available.names[count.index]}"
    map_public_ip_on_launch = false
    tags = {
      Name = "customer-private-subnet"
    }
}

resource "aws_security_group" "public_sg" {
name        = "public-sg"
description = "ssh and http"
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
resource "aws_security_group" "private_sg" {
name        = "private-sg"
description = "vpc to db"
vpc_id      = aws_vpc.customer_vpc.id

ingress {
    description      = "pubVPC to DB"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    cidr_blocks      = ["54.0.0.0/8"]
}
egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
}
tags = {
    Name = "allow_to_db"
    }  
}
resource "aws_eip" "nat_gateway"{
    vpc = true
}

resource "aws_route_table" "public_route_table" {
vpc_id = aws_vpc.customer_vpc.id
tags = {
    Name = "public_route"
}
}
resource "aws_main_route_table_association" "main-table" {
vpc_id         = aws_vpc.customer_vpc.id
route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route" "route-rt-igw" {
route_table_id            = aws_route_table.public_route_table.id
destination_cidr_block    = "0.0.0.0/0"
gateway_id                = aws_internet_gateway.gw.id
depends_on                = [aws_route_table.public_route_table]
}

output "public_sg" {
    value = aws_security_group.public_sg  
}
output "public_subnet" {
    value = aws_subnet.customer_subnet[0] 
}
output "private_sg" {
    value = aws_security_group.private_sg  
}
output "private_subnet_ids" {
    value = [aws_subnet.private_subnet[0].id, aws_subnet.private_subnet[1].id]
}