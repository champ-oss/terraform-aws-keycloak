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

module "core" {
  source             = "github.com/champ-oss/terraform-aws-core.git?ref=v1.0.119-061bf8b"
  git                = var.git
  name               = var.git
  vpc_id             = var.vpc_id
  public_subnet_ids  = var.public_subnet_ids
  private_subnet_ids = var.private_subnet_ids
  protect            = false
  tags               = merge(local.tags, var.tags)
  certificate_arn    = var.certificate_arn
}