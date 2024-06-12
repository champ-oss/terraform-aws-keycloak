terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.40.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = ">= 2.0.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
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

module "core" {
  source             = "github.com/champ-oss/terraform-aws-core.git?ref=v1.0.118-971d6db"
  git                = local.git
  name               = local.git
  vpc_id             = data.aws_vpcs.this.ids[0]
  public_subnet_ids  = data.aws_subnets.public.ids
  private_subnet_ids = data.aws_subnets.private.ids
  protect            = false
  certificate_arn    = module.acm.arn
}

module "acm" {
  source            = "github.com/champ-oss/terraform-aws-acm.git?ref=v1.0.116-cd36b2b"
  git               = local.git
  domain_name       = "keycloak.${data.aws_route53_zone.this.name}"
  create_wildcard   = false
  zone_id           = data.aws_route53_zone.this.zone_id
  enable_validation = true
}

module "this" {
  source                   = "../../"
  vpc_id                   = data.aws_vpcs.this.ids[0]
  subnets                  = data.aws_subnets.private.ids
  zone_id                  = data.aws_route53_zone.this.zone_id
  cluster_name             = module.core.ecs_cluster_name
  security_groups          = [module.core.ecs_app_security_group]
  execution_role_arn       = module.core.execution_ecs_role_arn
  listener_arn             = module.core.lb_public_listener_arn
  lb_dns_name              = module.core.lb_public_dns_name
  lb_zone_id               = module.core.lb_public_zone_id
  alb_arn_suffix           = module.core.lb_public_arn_suffix
  dns_name                 = "keycloak.${data.aws_route53_zone.this.name}"
  protect                  = false
  skip_final_snapshot      = true
  private_subnet_ids       = data.aws_subnets.private.ids
  source_security_group_id = module.core.ecs_app_security_group
}
