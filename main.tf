data "aws_region" "current" {}

resource "random_password" "shared_keycloak" {
  length  = 32
  special = false
}
