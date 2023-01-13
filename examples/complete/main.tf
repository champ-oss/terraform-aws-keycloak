provider "aws" {
  region = "us-east-2"
}

terraform {
  backend "s3" {}
}

locals {
  git = "terraform-aws-keycloak"
}

data "aws_route53_zone" "this" {
  name = "oss.champtest.net."
}

data "aws_vpcs" "this" {
  tags = {
    purpose = "vega"
  }
}

data "aws_subnets" "private" {
  tags = {
    purpose = "vega"
    Type    = "Private"
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpcs.this.ids[0]]
  }
}

data "aws_subnets" "public" {
  tags = {
    purpose = "vega"
    Type    = "Public"
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpcs.this.ids[0]]
  }
}

module "acm" {
  source            = "github.com/champ-oss/terraform-aws-acm.git?ref=v1.0.110-61ad6b7"
  git               = local.git
  domain_name       = "keycloak.${data.aws_route53_zone.this.name}"
  create_wildcard   = false
  zone_id           = data.aws_route53_zone.this.zone_id
  enable_validation = true
}

module "this" {
  source               = "../../"
  certificate_arn      = module.acm.arn
  public_subnet_ids    = data.aws_subnets.public.ids
  private_subnet_ids   = data.aws_subnets.private.ids
  vpc_id               = data.aws_vpcs.this.ids[0]
  domain               = data.aws_route53_zone.this.name
  zone_id              = data.aws_route53_zone.this.zone_id
  protect              = false
  skip_final_snapshot  = true
  enable_create_client = true
}

data "aws_ssm_parameter" "keycloak" {
  name = "keycloak_client_secret"
}

module "keycloak" {
  source        = "github.com/champ-oss/terraform-keycloak.git?ref=fdf79f0de3653d1694a0ea4591e301e3dee0db51"
  for_each = toset([
    "dev",
    "test",
    "qa",
  ])
  client_id     = "terraform-client"
  client_secret = data.aws_ssm_parameter.keycloak.value
  url           = module.this.keycloak_endpoint
  realm         = each.value
  attributes {
    foo = "bar",
  }
}
