data "aws_availability_zones" "available" {}
#data "aws_subnet_ids" "private" {
#    vpc_id = var.vpc_id
#}

resource "aws_vpc" "customer_vpc" {
    cidr_block = "110.0.0.0/16"
    enable_dns_hostnames = true
    tags = {
        Name = "customer-vpc"
}
}
resource "aws_vpc" "customer_private_vpc" {
  cidr_block           = "192.168.0.0/16"
  enable_dns_hostnames = true
  tags = {
        Name = "customer-private-vpc"
}
}
resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.customer_vpc.id
}


resource "aws_subnet" "customer_subnet" {
    count = "${length(data.aws_availability_zones.available.names)}"
    vpc_id = aws_vpc.customer_vpc.id
    cidr_block = "110.0.${1+count.index}.0/24"
    availability_zone= "${data.aws_availability_zones.available.names[count.index]}"
    map_public_ip_on_launch = true
    tags = {
        Name = "customer-public-subnet"
    map_public_ip_on_launch = true
}
}

resource "aws_subnet" "private_subnet" {
  count = "${length(data.aws_availability_zones.available.names)}"
  vpc_id = "${aws_vpc.customer_vpc.id}"
  cidr_block = "192.168.${20+count.index}.0/24"
  availability_zone= "${data.aws_availability_zones.available.names[count.index]}"
  map_public_ip_on_launch = false
  tags = {
      Name = "customer-private-subnet"
  }
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
resource "aws_security_group" "private_sg" {
name        = "private-sg"
description = "Allow the public Subnet to communicate"
vpc_id      = aws_vpc.customer_private_vpc.id

ingress {
    description      = "pubVPC to DB"
    from_port        = 3389
    to_port          = 3389
    protocol         = "tcp"
    cidr_blocks      = ["110.0.0.0/24"]
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

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = aws_subnet.customer_subnet.id
  tags = {
    Name = "gw NAT"
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

resource "aws_route" "route-rt-igw" {
route_table_id            = aws_route_table.customer_route_table.id
destination_cidr_block    = "0.0.0.0/0"
gateway_id                = aws_internet_gateway.gw.id
depends_on                = [aws_route_table.customer_route_table]
}

output "public_sg" {
    value = aws_security_group.public_sg  
}
output "public_subnet" {
    value = aws_subnet.customer_subnet 
}
output "private_sg" {
    value = aws_security_group.private_sg  
}
output "private_subnet" {
    value = aws_subnet.private_subnet 
}
