output "pub_subnets" {
  value = [
    aws_subnet.pub_sub1.id,
    aws_subnet.pub_sub2.id

  ]

}

output "vpc_id" {
  value = aws_vpc.vpc.id

}