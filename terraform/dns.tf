# fetches the details of an existing hosted zone on aws route53
data "aws_route53_zone" "docker-zone" {
  zone_id = lookup(var.access_key, "zone_id")
  private_zone = false
}

# creates a record on the hosted zone; value points towards the resources of the created 
resource "aws_route53_record" "docker-53" {
  zone_id = data.aws_route53_zone.docker-zone.zone_id
  name    = "terraform-test.${data.aws_route53_zone.docker-zone.name}"
  type    = "A"
  allow_overwrite = true
  ttl = 300
  records = [aws_eip.docker_eip.public_ip]
}

resource "aws_eip" "docker_eip" {
  instance = aws_instance.docker_ec2.id
  vpc = true
}
