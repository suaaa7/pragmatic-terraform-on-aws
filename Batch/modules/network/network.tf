data "aws_availability_zones" "current" {}

variable "azcount" {
  default = "1"
}

variable "project" {
  default = "batch"
}

# VPC
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "batch-vpc"
  }
}

# private subnet for each AZ
resource "aws_subnet" "private" {
  count = var.azcount
  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.current.names[count.index]

  tags = {
    Name = "${var.project}-private-subnet-${data.aws_availability_zones.current.names[count.index]}"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project}-internet-gateway"
  }
}

# Elastic IP for each AZ
resource "aws_eip" "eip" {
  count = var.azcount
  vpc = true
  depends_on = [aws_internet_gateway.gateway]

  tags = {
    Name = "${var.project}-EIP-${data.aws_availability_zones.current.names[count.index]}"
  }
}

# NAT gateway for each AZ
resource "aws_nat_gateway" "nat" {
  count = var.azcount
  allocation_id = element(aws_eip.eip.*.id, count.index)
  subnet_id = element(aws_subnet.private.*.id, count.index)
  depends_on = [aws_internet_gateway.gateway]

  tags = {
    Name = "${var.project}-Nat-${data.aws_availability_zones.current.names[count.index]}"
  }
}

# Route table for each private subnet
resource "aws_route_table" "private_route_table" {
  count = var.azcount
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project}-Private-Route-Table-${data.aws_availability_zones.current.names[count.index]}"
  }
}

# Route traffic in each private subnet through the respective NAT gateway
resource "aws_route" "private_subnet_route" {
  count = var.azcount
  route_table_id = element(aws_route_table.private_route_table.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = element(aws_nat_gateway.nat.*.id, count.index)
}

# Associate each routing table with the respective subnet
resource "aws_route_table_association" "private_subnet_route_association" {
  count = var.azcount
  subnet_id = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private_route_table.*.id, count.index)
}

output "vpc" {
  value = aws_vpc.vpc.id  
}

output "private_subnets" {
  value = [aws_subnet.private.*.id]
}
