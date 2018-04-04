variable "dns_ttl" {
  default = "86400"
}

resource "aws_route53_zone" "mowforth" {
  name = "mowforth.com"
}

resource "aws_route53_record" "mx-records" {
  zone_id = "${aws_route53_zone.mowforth.zone_id}"
  name    = "mowforth.com"
  type    = "MX"
  ttl     = "${var.dns_ttl}"

  records = [
    "1 aspmx.l.google.com.",
    "5 alt1.aspmx.l.google.com.",
    "5 alt2.aspmx.l.google.com.",
    "10 aspmx2.googlemail.com.",
    "10 aspmx3.googlemail.com.",
  ]
}

resource "aws_route53_record" "mail-shortcut" {
  zone_id = "${aws_route53_zone.mowforth.zone_id}"
  name = "mail.mowforth.com"
  type = "CNAME"
  ttl = "${var.dns_ttl}"
  records = ["ghs.google.com."]
}

resource "aws_route53_record" "mail-dkim" {
  zone_id = "${aws_route53_zone.mowforth.zone_id}"
  name = "google._domainkey.mowforth.com"
  type = "TXT"
  ttl = "${var.dns_ttl}"
  records = ["v=DKIM1; k=rsa; t=y; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCJyuFP4CLhBkDpsK2x2UBEwg5gjcZzCxFndrLnXoWux0KLTLSJxeO8tLIrJ5AIhbD70g0bF4mn98lsKjU0foIlZArlK0BmK+dESsHOJezc5xAwzmrJsquZLzp1N6vylCbHtH1NBti++EfjW0zGTUf5t3yYq1/WtWZnMqTZYYKAdQIDAQAB"]
}

resource "aws_route53_record" "chris-blog" {
  zone_id = "${aws_route53_zone.mowforth.zone_id}"
  name = "chris.mowforth.com"
  type = "A"
  ttl = "${var.dns_ttl}"
  records = ["52.17.166.253"]
}
