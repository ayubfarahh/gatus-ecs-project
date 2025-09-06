resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/24"
  
}

resource "aws_subnet" "pub_sub1" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.0.0/26"
  
}

resource "aws_subnet" "pub_sub2" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.0.64/26"
  
}