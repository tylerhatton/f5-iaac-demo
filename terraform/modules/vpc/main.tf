data "aws_availability_zones" "available" {
  state = "available"
}

# Internet VPC
resource "aws_vpc" "f5_openshift_demo" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "${var.name_prefix}-f5_openshift_demo"
  }
}

# Subnets
resource "aws_subnet" "f5_openshift_external" {
  vpc_id                  = aws_vpc.f5_openshift_demo.id
  cidr_block              = var.external_net_cidr
  map_public_ip_on_launch = "false"
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "${var.name_prefix}-f5_openshift_external"
  }
}

resource "aws_subnet" "f5_openshift_internal" {
  vpc_id                  = aws_vpc.f5_openshift_demo.id
  cidr_block              = var.internal_net_cidr
  map_public_ip_on_launch = "false"
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "${var.name_prefix}-f5_openshift_internal"
  }
}

resource "aws_subnet" "f5_openshift_mgmt" {
  vpc_id                  = aws_vpc.f5_openshift_demo.id
  cidr_block              = var.management_net_cidr
  map_public_ip_on_launch = "false"
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "${var.name_prefix}-f5_openshift_mgmt"
  }
}

# Internet GW
resource "aws_internet_gateway" "f5_openshift_gw" {
  vpc_id = aws_vpc.f5_openshift_demo.id

  tags = {
    Name = "${var.name_prefix}-f5_openshift_gw"
  }
}

# NAT GW

resource "aws_eip" "nat" {
  vpc = true

  tags = {
    Name = "${var.name_prefix}-f5_openshift_nat_eip"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.f5_openshift_external.id
  depends_on    = [aws_internet_gateway.f5_openshift_gw]

  tags = {
    Name = "${var.name_prefix}-f5-auto-nat_gw"
  }
}

# Route tables
resource "aws_route_table" "f5_openshift_public" {
  vpc_id = aws_vpc.f5_openshift_demo.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.f5_openshift_gw.id
  }

  tags = {
    Name = "${var.name_prefix}-f5_openshift_public"
  }
}

resource "aws_route_table" "f5_openshift_private" {
  vpc_id = aws_vpc.f5_openshift_demo.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "${var.name_prefix}-f5_openshift_private"
  }
}

# Route associations
resource "aws_route_table_association" "f5_openshift_external" {
  subnet_id      = aws_subnet.f5_openshift_external.id
  route_table_id = aws_route_table.f5_openshift_public.id
}

resource "aws_route_table_association" "f5_openshift_mgmt" {
  subnet_id      = aws_subnet.f5_openshift_mgmt.id
  route_table_id = aws_route_table.f5_openshift_public.id
}

resource "aws_route_table_association" "f5_openshift_internal" {
  subnet_id      = aws_subnet.f5_openshift_internal.id
  route_table_id = aws_route_table.f5_openshift_private.id
}