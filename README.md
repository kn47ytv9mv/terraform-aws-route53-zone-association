# terraform-aws-route53-zone-association

Terraform module for associating a VPC with a private Route53 hosted
zone. To create the zone itself, see
[`terraform-aws-route53-zone`](https://github.com/kn47ytv9mv/terraform-aws-route53-zone).

## Cost

No cost impact of its own — Route53 private hosted zone associations
carry no charge beyond the zone's own hourly rate, which this module does
not create. See AWS's
[Route53 pricing](https://aws.amazon.com/route53/pricing/) page for the
zone's own rate.

## Design

A private hosted zone only resolves for VPCs it is associated with —
network connectivity between VPCs (via peering or a transit gateway) does
not extend private DNS resolution automatically; each VPC that needs to
resolve the zone's records needs its own association.

Same-account, cross-region associations work directly through this
module — set `vpc_region` to the VPC's region, and run it under a
provider configured for the *zone's* region (Route53 always manages
zone associations from the zone's own region). Cross-account
associations need one extra step: the zone-owning account first
authorizes the VPC with
[`terraform-aws-route53-vpc-association-authorization`](https://github.com/kn47ytv9mv/terraform-aws-route53-vpc-association-authorization);
the VPC-owning account then runs this same module (under its own
provider) to complete the association — reused by both sides rather
than needing a separate accepter module.

## Usage

```hcl
module "association" {
  source = "kn47ytv9mv/route53-zone-association/aws"

  zone_id = module.private_zone.zone_id
  vpc_id  = module.vpc.vpc_id
}
```

Or directly from this repository, for a same-account VPC in another
region:

```hcl
module "association" {
  source = "github.com/kn47ytv9mv/terraform-aws-route53-zone-association"

  zone_id    = module.private_zone.zone_id
  vpc_id     = module.vpc_eu_west_1.vpc_id
  vpc_region = "eu-west-1"
}
```

## Requirements

| Name | Version |
|---|---|
| terraform | >= 1.0 |
| aws | ~> 6.61 |

## Providers

| Name | Version |
|---|---|
| aws | ~> 6.61 |

## Inputs

| Name | Description | Default | Required |
|---|---|---|---|
| zone_id | The ID of the private hosted zone to associate the VPC with. | `null` | no |
| vpc_id | The ID of the VPC to associate. | `null` | no |
| vpc_region | Region of the VPC, for cross-region association. If null, the VPC is assumed to be in this provider's own region. Cross-account association additionally requires the zone-owning account to authorize the VPC first with `terraform-aws-route53-vpc-association-authorization`. | `null` | no |

## Outputs

| Name | Description |
|---|---|
| id | The ID of the zone association. |
| owning_account | AWS account ID that owns the private hosted zone. |

## License

MIT — see [LICENSE.md](LICENSE.md).
