resource "aws_vpc" "customer_vpc" {
  cidr_block = "110.0.0.0/16"
  tags = {
    Name = "customer-vpc"
  }
}

resource "aws_subnet" "customer_subnet" {
  vpc_id = aws_vpc.customer_vpc.id
  cidr_block = "110.0.0.0/24"
  tags = {
    Name = "customer-subnet"
  }
}