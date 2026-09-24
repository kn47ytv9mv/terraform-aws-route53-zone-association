mock_provider "aws" {
}

run "required_arguments_pass_through" {
  command = plan

  variables {
    zone_id = "Z0123456789ABCDEFGHIJ"
    vpc_id  = "vpc-0123456789abcdef0"
  }

  assert {
    condition     = aws_route53_zone_association.resource.zone_id == "Z0123456789ABCDEFGHIJ"
    error_message = "zone_id should pass through unchanged."
  }

  assert {
    condition     = aws_route53_zone_association.resource.vpc_id == "vpc-0123456789abcdef0"
    error_message = "vpc_id should pass through unchanged."
  }
}

run "vpc_region_passes_through_for_cross_region" {
  command = plan

  variables {
    zone_id    = "Z0123456789ABCDEFGHIJ"
    vpc_id     = "vpc-0123456789abcdef0"
    vpc_region = "eu-west-1"
  }

  assert {
    condition     = aws_route53_zone_association.resource.vpc_region == "eu-west-1"
    error_message = "vpc_region should pass through unchanged."
  }
}

run "readme_default_example" {
  command = plan

  variables {
    zone_id = "Z0123456789ABCDEFGHIJ"
    vpc_id  = "vpc-0123456789abcdef0"
  }
}

run "readme_cross_region_example" {
  command = plan

  variables {
    zone_id    = "Z0123456789ABCDEFGHIJ"
    vpc_id     = "vpc-0123456789abcdef0"
    vpc_region = "eu-west-1"
  }
}
