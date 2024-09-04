# Create a VPC
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16" #This cyder block alows all 65,536 possible IP addresses to be avaliable for use in the VPC
  
  tags = {
    Name = "YT_VPC"
  }
}

# Create a public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-2a"  # Change to your availability zone if needed
  
  tags = {
    Name = "public_subnet_for_youtube"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  
  tags = {
    Name = "my_igw"
  }
}

# Create a route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  
  route {
    cidr_block = "0.0.0.0/0"  # Default route to the internet
    gateway_id = aws_internet_gateway.igw.id
  }
  
  tags = {
    Name = "public_route_table"
  }
}

# Associate the route table with the public subnet
resource "aws_route_table_association" "my_public_route_table_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}