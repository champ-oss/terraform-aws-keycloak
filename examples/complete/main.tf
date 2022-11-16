provider "aws" {
  region = "us-west-1"
}

locals {
  git = "terraform-aws-keycloak"
}

data "aws_route53_zone" "this" {
  name = "oss.champtest.net."
}

module "vpc" {
  source                   = "github.com/champ-oss/terraform-aws-vpc.git?ref=v1.0.39-9596bfc"
  git                      = local.git
  availability_zones_count = 2
  retention_in_days        = 1
}

module "acm" {
  source            = "github.com/champ-oss/terraform-aws-acm.git?ref=v1.0.109-483b25a"
  git               = local.git
  domain_name       = "${local.git}.${data.aws_route53_zone.this.name}"
  create_wildcard   = false
  zone_id           = data.aws_route53_zone.this.zone_id
  enable_validation = true
}

module "this" {
  source              = "../../"
  certificate_arn     = module.acm.arn
  private_subnet_ids  = module.vpc.private_subnets_ids
  public_subnet_ids   = module.vpc.public_subnets_ids
  vpc_id              = module.vpc.vpc_id
  domain              = data.aws_route53_zone.this.name
  zone_id             = data.aws_route53_zone.this.zone_id
  protect             = false
  skip_final_snapshot = true
}