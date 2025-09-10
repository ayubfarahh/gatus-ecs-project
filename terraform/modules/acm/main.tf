resource "aws_acm_certificate" "cert" {
    domain_name = "dev.coderco.ayubs.uk"
    validation_method = "DNS"
    
    lifecycle {
      create_before_destroy = true
    }
}

variable "zone_id" { type = string }

resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options :
    dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id = var.alb_zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 60
  records = [each.value.record]
  allow_overwrite = true
}

