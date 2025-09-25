output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}

output "alb_zone_id" {
  value = aws_lb.alb.zone_id
}

output "alb_tg_arn" {
  value = aws_lb_target_group.alb_tg.arn

}

output "alb_sg" {
  value = aws_security_group.sg_alb.id

}