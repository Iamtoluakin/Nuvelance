/*==== The VPC ======*/
resource "aws_vpc" "Nuvalence_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Nuvalence_vpc"
  }
}
/* public subnet */

resource "aws_subnet" "public_Nuvalence" {
  vpc_id                  = aws_vpc.Nuvalence_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "Nuvalence_Public"
  }
}
/* private subnet */

resource "aws_subnet" "private_Nuvalence" {
  vpc_id     = aws_vpc.Nuvalence_vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "Nuvalence_Private"
  }
}
/* Elastic IP for NAT */
resource "aws_eip" "nat_eip" {
  vpc = true

  /* Internet gateway*/
}
resource "aws_internet_gateway" "nuvance_gw" {
  vpc_id = aws_vpc.Nuvalence_vpc.id

  tags = {
    Name = "Nuvalence"
  }
}
/* NAT */
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_Nuvalence.id
  tags = {
    Name = "nuvalence_nat"
  }
}
/* Routing table for private subnet */
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.Nuvalence_vpc.id
  tags = {
    Name = "PrivateNuvalence"
  }
}
/* Routing table for public subnet */
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.Nuvalence_vpc.id
  tags = {
    Name = "PublicNuvalence"
  }
}
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.nuvance_gw.id
}
resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}
/* Route table associations */
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public_Nuvalence.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private_Nuvalence.id
  route_table_id = aws_route_table.private.id
}
/*==== VPC's Default Security Group ======*/
resource "aws_security_group" "default" {
  name        = "Nuvalence"
  description = "Default security group to allow inbound/outbound from the VPC"
  vpc_id      = aws_vpc.Nuvalence_vpc.id
  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = "true"
  }
  tags = {
    Environment = "${var.environment}"
  }
}