resource "aws_route53_zone_association" "resource" {
  zone_id    = var.zone_id
  vpc_id     = var.vpc_id
  vpc_region = var.vpc_region
}

output "id" {
  description = "The ID of the zone association."
  value       = aws_route53_zone_association.resource.id
}

output "owning_account" {
  description = "AWS account ID that owns the private hosted zone."
  value       = aws_route53_zone_association.resource.owning_account
}
