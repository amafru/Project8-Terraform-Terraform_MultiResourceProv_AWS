//Create VPC
resource "aws_vpc" "project8-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "project8-vpc"
  }
}

//Create public subnets
resource "aws_subnet" "project8-pub-sub1" {
  vpc_id                  = aws_vpc.project8-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1

  tags = {
    Name = "project8-pub-sub1"
  }
}
resource "aws_subnet" "project8-pub-sub2" {
  vpc_id                  = aws_vpc.project8-vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE2

  tags = {
    Name = "project8-pub-sub2"
  }
}
resource "aws_subnet" "project8-pub-sub3" {
  vpc_id                  = aws_vpc.project8-vpc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE3

  tags = {
    Name = "project8-pub-sub3"
  }
}
//Create private subnets
resource "aws_subnet" "project8-priv-sub1" {
  vpc_id                  = aws_vpc.project8-vpc.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1

  tags = {
    Name = "project8-priv-sub1"
  }
}
resource "aws_subnet" "project8-priv-sub2" {
  vpc_id                  = aws_vpc.project8-vpc.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE2

  tags = {
    Name = "project8-priv-sub2"
  }
}
resource "aws_subnet" "project8-priv-sub3" {
  vpc_id                  = aws_vpc.project8-vpc.id
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE3

  tags = {
    Name = "project8-priv-sub3"
  }
}

//Create IGW for use by public subnets
resource "aws_internet_gateway" "project8-igw" {
  vpc_id = aws_vpc.project8-vpc.id

  tags = {
    Name = "project8-IGW"
  }
}

//Create route table
resource "aws_route_table" "project8-RT" {
  vpc_id = aws_vpc.project8-vpc.id 

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project8-igw.id
  }

  tags = {
    Name = "project8-route-table"
  }
}

//Implement Route Table Association ----
resource "aws_route_table_association" "project8-pubsub1-RT-assoc" {
  subnet_id      = aws_subnet.project8-pub-sub1.id
  route_table_id = aws_route_table.project8-RT.id
}
resource "aws_route_table_association" "project8-pubsub2-RT-assoc" {
  subnet_id      = aws_subnet.project8-pub-sub2.id
  route_table_id = aws_route_table.project8-RT.id
}
resource "aws_route_table_association" "project8-pubsub3-RT-assoc" {
  subnet_id      = aws_subnet.project8-pub-sub3.id
  route_table_id = aws_route_table.project8-RT.id
}

//Create Security group
//We'll use a different file for this one "secgroup.tf"