variable "zone_id" {
  default     = null
  description = "The ID of the private hosted zone to associate the VPC with."
}

variable "vpc_id" {
  default     = null
  description = "The ID of the VPC to associate."
}

variable "vpc_region" {
  default     = null
  description = "Region of the VPC, for cross-region association. If null, the VPC is assumed to be in this provider's own region. Cross-account association additionally requires the zone-owning account to authorize the VPC first with terraform-aws-route53-vpc-association-authorization."
}
