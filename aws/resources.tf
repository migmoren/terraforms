resource "aws_vpc" "mike-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name  = "mike-vpc"
  }
}

resource "aws_instance" "mike-instance1" {
  ami                         = "ami-03aa99ddf5498ceb9" # Ubuntu Server 20.04, AMD64
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.mike-subnet.id
  vpc_security_group_ids      = [aws_security_group.mike-sg.id]
  key_name                    = aws_key_pair.mike-key.key_name
  associate_public_ip_address = true
  user_data                   = file("bootstrap.sh")

  tags = {
    Name  = "web1"
  }
}

resource "aws_key_pair" "mike-key" {
  key_name   = "mike-key"
  public_key = file("~/.ssh/terraforms.pub")
}

resource "aws_security_group" "mike-sg" {
  name        = "mike-sg"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = aws_vpc.mike-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["187.190.197.43/32"] # TP IP
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["187.190.197.43/32"] # TP IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"          # All protocols
    cidr_blocks = ["0.0.0.0/0"] # Allow all IPs
  }

  tags = {
    Name  = "mike-sg"
  }
}

resource "aws_subnet" "mike-subnet" {
  vpc_id                  = aws_vpc.mike-vpc.id
  cidr_block              = "10.0.1.0/28" # 16 IP addresses
  map_public_ip_on_launch = true

  tags = {
    Name  = "mike-subnet"
  }
}

resource "aws_internet_gateway" "mike-igw" {
  vpc_id = aws_vpc.mike-vpc.id

  tags = {
    Name  = "mike-igw"
  }
}

resource "aws_route_table" "mike-rt" {
  vpc_id = aws_vpc.mike-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mike-igw.id
  }
  tags = {
    Name  = "mike-rt"
  }
}

resource "aws_route_table_association" "mike-rt-assoc" {
  subnet_id      = aws_subnet.mike-subnet.id
  route_table_id = aws_route_table.mike-rt.id
}
