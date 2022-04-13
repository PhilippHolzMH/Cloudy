data "aws_availability_zones" "available" {}


resource "aws_vpc" "customer_private_vpc" {
  cidr_block           = "192.168.0.0/16"
  enable_dns_hostnames = false
  tags = {
    Name = "customer-private-vpc"
    }
}
resource "aws_subnet" "private_subnet" {
  count = "${length(data.aws_availability_zones.available.names)}"
  vpc_id = "${aws_vpc.customer_private_vpc.id}"
  cidr_block = "192.168.${20+count.index}.0/24"
  availability_zone= "${data.aws_availability_zones.available.names[count.index]}"
  map_public_ip_on_launch = false
  tags = {
    Name = "customer-private-subnet"
    }
}
resource "aws_security_group" "private_sg" {
  name        = "private-sg"
  description = "Allow the public Subnet to communicate"
  vpc_id      = aws_vpc.customer_private_vpc.id

  ingress {
    description      = "SSH to VPC"
    from_port        = 22
    to_port          = 22
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
}

output "private_sg" {
    value = aws_security_group.private_sg  
}
output "private_subnet" {
    value = aws_subnet.private_subnet[0]
}
