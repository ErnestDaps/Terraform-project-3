# Creating networking for the project 
resource "aws_vpc" "Prod_rock_VPC" {
  cidr_block           = var.VPC-cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "Prod-rock-VPC"
  }

}

# Public Subnet 1 
resource "aws_subnet" "Test_Public_Sub1" {
  vpc_id            = aws_vpc.Prod_rock_VPC.id
  cidr_block        = var.public-sub1-cidr
  availability_zone = var.AZ1

  tags = {
    Name = "Test_Public_Sub1"
  }

}

# Public Subnet 2 
resource "aws_subnet" "Test_public_Sub2" {
  vpc_id            = aws_vpc.Prod_rock_VPC.id
  cidr_block        = var.public-sub2-cidr
  availability_zone = var.AZ2

  tags = {
    Name = "Test_public_Sub2"
  }

}

# Private Subnet 1 
resource "aws_subnet" "Test_priv_Sub1" {
  vpc_id            = aws_vpc.Prod_rock_VPC.id
  cidr_block        = var.private-sub1-cidr
  availability_zone = var.AZ1

  tags = {
    Name = "Test_priv_Sub1"
  }

}


# Private Subnet 2 
resource "aws_subnet" "Test_priv_Sub2" {
  vpc_id            = aws_vpc.Prod_rock_VPC.id
  cidr_block        = var.private-sub2-cidr
  availability_zone = var.AZ2

  tags = {
    Name = "Test_priv_Sub2"
  }

}


# Public Route table 
resource "aws_route_table" "Test_pub_route_table" {
  vpc_id = aws_vpc.Prod_rock_VPC.id

  tags = {
    Name = "Test_pub_route_table"
  }

}

# Private Route table (test-Nat-association)
resource "aws_route_table" "Test_priv_route_table" {
  vpc_id = aws_vpc.Prod_rock_VPC.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.Test_Nat_gateway.id
  }

  tags = {
    Name = "Test-priv-route-table"
  }

}

# Public subnets associate with the public route table 
resource "aws_route_table_association" "public_sub1_route_assoc" {
  subnet_id      = aws_subnet.Test_Public_Sub1.id
  route_table_id = aws_route_table.Test_pub_route_table.id
}

resource "aws_route_table_association" "public_sub2_route_assoc" {
  subnet_id      = aws_subnet.Test_public_Sub2.id
  route_table_id = aws_route_table.Test_pub_route_table.id
}

# Associate private subnets with the private route table 
resource "aws_route_table_association" "private_sub1_route_assoc" {
  subnet_id      = aws_subnet.Test_priv_Sub1.id
  route_table_id = aws_route_table.Test_priv_route_table.id
}

resource "aws_route_table_association" "private_sub2_route_assoc" {
  subnet_id      = aws_subnet.Test_priv_Sub2.id
  route_table_id = aws_route_table.Test_priv_route_table.id
}

# Internet Gateway 
resource "aws_internet_gateway" "Test_igw" {
  vpc_id = aws_vpc.Prod_rock_VPC.id

  tags = {
    Name = "Test-igw"
  }

}

# Internet gateway association with the public route table 
resource "aws_route" "IGW_Pub_route_assoc" {
  route_table_id         = aws_route_table.Test_pub_route_table.id
  gateway_id             = aws_internet_gateway.Test_igw.id
  destination_cidr_block = "0.0.0.0/0"
}

# Allocate elastic ip address for the Nat gateway
resource "aws_eip" "EIP_for_nat_gateway" {
  vpc = true
  tags = {
    Name = "EIP-for-nat-gateway"
  }
}

# Creating Nat gateway
resource "aws_nat_gateway" "Test_Nat_gateway" {
  allocation_id = aws_eip.EIP_for_nat_gateway.id
  subnet_id     = aws_subnet.Test_Public_Sub1.id

  tags = {
    Name = "Test-Nat-gateway"
  }

}