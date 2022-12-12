module "keycloak" {
  source                = "github.com/champ-oss/terraform-aws-app.git?ref=v1.0.188-339276b"
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
  name     = "keycloak"
  dns_name = local.keycloak_dns_name
  image    = var.image_shared_keycloak
  cpu      = "2048"
  memory   = "4096"

  healthcheck                       = "/admin"
  health_check_grace_period_seconds = 300
  environment = {
    KC_DB_URL_HOST                 = module.aurora.endpoint
    KC_DB_URL_DATABASE             = module.aurora.database_name
    KC_DB_USERNAME                 = module.aurora.master_username
    KC_DB                          = "mysql"
    KEYCLOAK_ADMIN                 = var.keycloak_admin_user
    KC_HEALTH_ENABLED              = var.healthcheck_enabled
    KC_METRICS_ENABLED             = var.kc_metrics_enabled
    KC_LOG_LEVEL                   = var.kc_loglevel
    KC_HOSTNAME                    = local.keycloak_dns_name
    KC_HOSTNAME_STRICT_HTTPS       = var.hostname_strict_https
    KC_HOSTNAME_STRICT_BACKCHANNEL = var.hostname_strict_backchannel
    KC_HTTP_ENABLED                = var.http_enabled
    KC_PROXY                       = var.proxy
    PROXY_ADDRESS_FORWARDING       = "true"
    JGROUPS_DISCOVERY_PROTOCOL     = "JDBC_PING"
    JGROUPS_DISCOVERY_PROPERTIES   = var.jgroups_discovery_properties
    JAVA_OPTS                      = "-Djava.net.preferIPv4Stack=true -Djava.net.preferIPv4Addresses"
    KC_CACHE_STACK                 = "tcp"
  }
  ## passing passwords as secrets
  secrets = {
    KC_DB_PASSWORD          = module.aurora.password_ssm_name
    KEYCLOAK_ADMIN_PASSWORD = aws_ssm_parameter.keycloak_password.name
  }
  command      = var.app_command
  min_capacity = var.app_min_capacity
  max_capacity = var.app_max_capacity

  # enable slack error alerting
  enable_lambda_cw_alert = var.enable_lambda_cw_alert
  slack_url              = var.cloudwatch_slack_url != "" ? var.cloudwatch_slack_url : null
  filter_pattern         = var.filter_pattern != "" ? var.filter_pattern : null
  depends_on             = [module.aurora]

  # sticky session on lb
  stickiness = [{
    enabled : true,
    type : "lb_cookie"
    cookie_duration : 43200,
  }]
}
