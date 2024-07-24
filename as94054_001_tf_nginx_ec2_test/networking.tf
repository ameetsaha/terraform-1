locals {
  common_tags = {
    Managed_By = "Terraform"
    Project    = "tfcode_session_with_AmitSaha"
    Lab_Source = "UdemyWeb"
  }
}

resource "aws_vpc" "as94054_001" {
  cidr_block = "10.0.0.0/16"

  tags = merge(local.common_tags, {
    Name = "VPC for project as94054_001"
  })
}

resource "aws_subnet" "as94054_001_privsub" {
  cidr_block = "10.0.0.0/24"
  vpc_id     = aws_vpc.as94054_001.id

  tags = merge(local.common_tags, {
    Name = "Private Subnet for project as94054_001"
  })
}

resource "aws_subnet" "as94054_001_pubsub" {
  cidr_block = "10.0.1.0/24"
  vpc_id     = aws_vpc.as94054_001.id

  tags = merge(local.common_tags, {
    Name = "Public Subnet for project as94054_001"
  })
}

resource "aws_internet_gateway" "as94054_001_ig" {
  vpc_id = aws_vpc.as94054_001.id

  tags = merge(local.common_tags, {
    Name = "Internet Gateway for project as94054_001"
  })
}

resource "aws_route_table" "as94054_001_rtb" {
  vpc_id = aws_vpc.as94054_001.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.as94054_001_ig.id
  }

  tags = merge(local.common_tags, {
    Name = "Route Table for project as94054_001"
  })

}

resource "aws_route_table_association" "as94054_001_rtb_public_44" {
  subnet_id      = aws_subnet.as94054_001_pubsub.id
  route_table_id = aws_route_table.as94054_001_rtb.id
}