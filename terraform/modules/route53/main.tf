resource "aws_route53_zone" "dns" {
  name = "coderco.ayubs.uk"

}

resource "aws_route53_record" "root" {
  zone_id = aws_route53_zone.dns.zone_id
  name    = "dev.coderco.ayubs.uk"
  type    = "A"


  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }

}