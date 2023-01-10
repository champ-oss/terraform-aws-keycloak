data "aws_region" "current" {}

resource "random_string" "identifier" {
  length  = 5
  special = false
  upper   = false
  lower   = true
  number  = true
}

resource "random_password" "shared_keycloak" {
  length  = 32
  special = false
}

resource "random_password" "keycloak_client_secret" {
  length  = 36
  special = false
  upper   = false
  lower   = true
  number  = true
}


module "core" {
  source             = "github.com/champ-oss/terraform-aws-core.git?ref=v1.0.110-d6bf5be"
  git                = var.git
  name               = var.git
  vpc_id             = var.vpc_id
  public_subnet_ids  = var.public_subnet_ids
  private_subnet_ids = var.private_subnet_ids
  protect            = false
  tags               = merge(local.tags, var.tags)
  certificate_arn    = var.certificate_arn
}
