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
  }
}
resource "aws_route_table" "customer_route_table" {
  vpc_id = aws_vpc.customer_vpc.id

  tags = {
    Name = "public_route"
  }
}

resource "aws_route" "prod-route-igw" {
  route_table_id            = aws_route_table.customer_route_table.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.gw.id
  depends_on                = [aws_route_table.customer_route_table]
}
