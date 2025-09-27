resource "aws_vpc" "mike-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "mike-vpc"
    owner = "mimorgaldevops2024@gmail.com"
  }
}


resource "aws_instance" "mike-instance1" {
  ami           = "ami-06a974f9b8a97ecf2"
  instance_type = "t3.micro"
  tags = {
    Name = "web1"
    owner = "mimorgaldevops2024@gmail.com"
  }
}
