# creates a vpc having ipv4 dns support (otherwise connecting ansible with the ec2 instances will be impossible)
resource "aws_vpc" "docker-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true 
  enable_dns_hostnames = true 
  assign_generated_ipv6_cidr_block = true 
  instance_tenancy = "default"

  tags = {
    Name = "docker-vpc"
  }
}

# creates a public subnet
resource "aws_subnet" "docker-subnet" {
  vpc_id = aws_vpc.docker-vpc.id
  cidr_block = lookup(var.docker_var, "cidr")
  availability_zone = lookup(var.docker_var, "zone")
  
  map_public_ip_on_launch = true


  tags = {
    "Name" = "docker-subnet"
  }
}

resource "aws_internet_gateway" "docker-igw" {
  vpc_id = aws_vpc.docker-vpc.id
  tags = {
    Name = "docker-igw"
  }
}

resource "aws_route_table" "docker-rt" {
    vpc_id = aws_vpc.docker-vpc.id

    route {
        cidr_block = lookup(var.docker_var, "route_table")
        gateway_id = aws_internet_gateway.docker-igw.id
    }

    tags = {
        Name = "docker-rt"
    }
}

resource "aws_route_table_association" "docker-rt-association" {
    subnet_id = aws_subnet.docker-subnet.id
    route_table_id = aws_route_table.docker-rt.id
}