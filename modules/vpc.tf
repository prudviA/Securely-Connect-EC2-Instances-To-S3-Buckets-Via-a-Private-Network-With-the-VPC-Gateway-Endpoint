# crearing vpc
resource "aws_vpc" "s3_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "s3_vpc"
  }
}
# public_subnet
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.s3_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"

  tags = {
    Name = "public_subnet"
  }
}

# private_subnet
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.s3_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "private_subnet"
  }
}
# internet_gateway
resource "aws_internet_gateway" "3-igw" {
  vpc_id = aws_vpc.s3_vpc.id

  tags = {
    Name = "3-igw"
  }
}
# route_table

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.s3_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.3-igw.id
  }
 tags = {
    Name = "public_rt"
  }
}

# route_table_association
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}
 
 # private route_table

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.s3_vpc.id

 tags = {
    Name = "private_rt"
  }
}

# vpc endpoint

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.s3_vpc.id
  service_name = "com.amazonaws.us-east-1.s3"
  route_table_ids = [aws_route_table.private_rt.id]
  vpc_endpoint_type = "Gateway"

  tags = {
    Name = "s3_vpc_endpoint"
  }
}

