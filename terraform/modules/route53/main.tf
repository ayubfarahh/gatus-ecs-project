resource "aws_route53_zone" "zone" {
    name = "ayubs.uk"
  
}

resource "aws_route53_record" "root" {
    name = "test.ayubs.uk"
    type = "A"
    ttl = 300

    alias {
      name = 
    }

  
}