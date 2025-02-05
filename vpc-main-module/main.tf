resource "aws_vpc" "vpc" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"

  tags = merge(
    var.common_tags,
    var.vpc_tags,
    {
        Name = "vpc"
    }
  )
}

# creating internet gateway

resource "aws_internet_gateway" "igw"{
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    var.common_tags,
    {
        Name = "igw"
    }
  )
}
# creating public subnets

resource "aws_subnet" "public-subnet" {
  count = length(var.cidr_public)
  vpc_id     = aws_vpc.vpc.id
  availability_zone = local.value[count.index]
  cidr_block = var.cidr_public[count.index]

  tags =merge(
    var.common_tags,
  {
    Name = "${var.project}-public-${local.value[count.index]}"
  }
  )
}

# creating private subnets
resource "aws_subnet" "private-subnet" {
  count = length(var.cidr_private)
  vpc_id     = aws_vpc.vpc.id
  availability_zone = local.value[count.index]
  cidr_block = var.cidr_private[count.index]

  tags = merge(
    var.common_tags,
   {
    Name = "${var.project}-private-${local.value[count.index]}"
  }
  )
}
# creating database subnets
resource "aws_subnet" "database-subnet" {
  count = length(var.cidr_database)
  vpc_id     = aws_vpc.vpc.id
  availability_zone = local.value[count.index]
  cidr_block = var.cidr_database[count.index]

  tags = merge(
    var.common_tags,
   {
    Name = "${var.project}-database-${local.value[count.index]}"
  }
  )
}

resource "aws_eip" "elastic_ip" {
  domain   = "vpc"

  tags = merge(
    var.common_tags,
    {
        Name = "${var.project}"
    }
  )
}

# creating NAT gateway
resource "aws_nat_gateway" "nat-gateway" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id     = aws_subnet.public-subnet[0].id

  tags = merge(
    var.common_tags,
   {
    Name = "${var.project}-nat"
  }
  )

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}

#creating route table for public subnet

resource "aws_route_table" "public-route" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(
    var.common_tags,
   {
    Name = "${var.project}-public"
  }
  )
}

# creating route table for private subnet
resource "aws_route_table" "private-route"{
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gateway.id
  }

  tags = merge(
    var.common_tags,
   {
    Name = "${var.project}-private"
  }
  )
}


# creating route table for database subnet
resource "aws_route_table" "database-route" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gateway.id
  }

  tags = merge(
    var.common_tags,
   {
    Name = "${var.project}-database"
  }
  )
}

# adding igw to main vpc route table 
resource "aws_route" "vpc-route" {
  route_table_id            = aws_vpc.vpc.main_route_table_id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}

#associating public route table to public subnet
resource "aws_route_table_association" "public-associate" {
  count = length(var.cidr_public)
  subnet_id      = aws_subnet.public-subnet[count.index].id
  route_table_id = aws_route_table.public-route.id
}

#associating private route table to private subnet
resource "aws_route_table_association" "private-associate" {
 count = length(var.cidr_private)
  subnet_id      = aws_subnet.private-subnet[count.index].id
  route_table_id = aws_route_table.private-route.id
}

#associating database route table to database subnet
resource "aws_route_table_association" "database-associate" {
  count = length(var.cidr_database)
  subnet_id      = aws_subnet.database-subnet[count.index].id
  route_table_id = aws_route_table.database-route.id
}





