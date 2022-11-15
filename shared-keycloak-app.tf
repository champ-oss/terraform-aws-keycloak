module "shared_keycloak" {
  source                = "github.com/champ-oss/terraform-aws-app.git?ref=v1.0.169-2247a4d"
  git                   = "${var.git}-${random_string.identifier.result}"
  vpc_id                = var.vpc_id
  subnets               = var.private_subnet_ids
  cluster               = module.core.ecs_cluster_name
  zone_id               = var.zone_id
  security_groups       = [module.core.ecs_app_security_group]
  execution_role_arn    = module.core.execution_ecs_role_arn
  wait_for_steady_state = true
  tags                  = merge(local.tags, var.tags)

  # public service vs private service
  listener_arn = module.core.lb_public_listener_arn
  lb_dns_name  = module.core.lb_public_dns_name
  lb_zone_id   = module.core.lb_public_zone_id

  # app specific variables
  name     = "shared-keycloak"
  dns_name = merge(local.dns_name, var.dns_name)["shared_keycloak"]
  image    = var.image_shared_keycloak
  cpu      = "2048"
  memory   = "4096"
  environment = {
    DB_ADDR                  = module.aurora_keycloak.endpoint
    DB_DATABASE              = module.aurora_keycloak.database_name
    DB_PORT                  = tostring(module.aurora_keycloak.port)
    DB_USER                  = module.aurora_keycloak.master_username
    DB_VENDOR                = var.db_vendor
    KEYCLOAK_USER            = var.keycloak_user
    PROXY_ADDRESS_FORWARDING = "true"
  }

  secrets = {
    DB_PASSWORD       = module.aurora_keycloak.master_password
    KEYCLOAK_PASSWORD = aws_ssm_parameter.shared_keycloak.name
  }
  port         = 443
  min_capacity = var.app_min_capacity
  max_capacity = var.app_max_capacity

  # enable slack error alerting
  enable_lambda_cw_alert = var.enable_lambda_cw_alert
  slack_url              = var.cloudwatch_slack_url != "" ? var.cloudwatch_slack_url : null
  filter_pattern         = var.filter_pattern != "" ? var.filter_pattern : null
}