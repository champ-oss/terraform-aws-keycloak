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

resource "null_resource" "exec_create_client_script" {
  provisioner "local-exec" {

    command     = "sleep 180 && chmod +x ../../create-client.sh;../../create-client.sh"
    interpreter = ["bash", "-c"]
    environment = {
      KC_HOSTNAME             = module.this.keycloak_endpoint
      KEYCLOAK_ADMIN          = "admin"
      KEYCLOAK_ADMIN_PASSWORD = module.this.keycloak_admin_password
      KEYCLOAK_CLIENT_ID      = "terraform-client"
      KEYCLOAK_CLIENT_SECRET  = data.aws_ssm_parameter.keycloak.value
    }
  }
  depends_on = [module.this]
}

module "smtp_user" {
  source = "github.com/champ-oss/terraform-aws-ses-smtp-users.git?ref=16f7459841043af28c0875976460ebbb8fde4005"
}

module "keycloak_main" {
  source        = "github.com/champ-oss/terraform-keycloak.git?ref=13ac381f9c69d4b61e9fb059554cea3a6cdb3b45"
  client_id     = "terraform-client"
  client_secret = data.aws_ssm_parameter.keycloak.value
  url           = module.this.keycloak_endpoint
  realm         = "main"
  attributes = {
    foo : "bar"
  }
  smtp_host     = "email-smtp.us-east-2.amazonaws.com"
  email_from    = "example@example.com"
  smtp_username = module.smtp_user.smtp_username
  smtp_password = module.smtp_user.smtp_password
}
