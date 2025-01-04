resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name = var.name
  }
}

# Public Subnet
resource "aws_subnet" "public_subnet" {
  count = length(var.public_subnets)

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnets[count.index]
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zones[count.index]

  tags = {
    Name = "${var.name}-public-${count.index}"
  }
}

# Private Subnet
resource "aws_subnet" "private_subnet" {
  count = length(var.private_subnets)

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnets[count.index]
  map_public_ip_on_launch = false
  availability_zone       = var.availability_zones[count.index]

  tags = {
    Name = "${var.name}-private-${count.index}"
  }
}
# Internet Gateway
resource "aws_internet_gateway" "igw" {
  count = length(var.public_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.vpc.id
  
  tags = {
    Name = "${var.name}-igw"
  }

}
# Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.name}-public-rt"
  }
}

# Private Route Table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.name}-private-rt"
  }
}

# Route Table Association for Public Subnets
resource "aws_route_table_association" "public_assoc" {
  count = length(aws_subnet.public_subnet)

  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

# Route Table Association for Private Subnets
resource "aws_route_table_association" "private_assoc" {
  count = length(aws_subnet.private_subnet)

  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route" "public_internet_gateway" {
  count = length(aws_internet_gateway.igw) > 0 ? 1 : 0

  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw[0].id

}