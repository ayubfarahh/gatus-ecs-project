resource "aws_route53_zone" "zone" {
    name = "ayubs.uk"
  
}

resource "aws_route53_record" "root" {
    zone_id = aws_route53_zone.zone.zone_id
    name = "test.ayubs.uk"
    type = "A"
    ttl = 300

    alias {
      name = var.alb_dns_name
      zone_id = var.alb_zone_id
      evaluate_target_health = true
    }
  
}