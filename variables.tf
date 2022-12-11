locals {
  keycloak_dns_name = var.keycloak_hostname != null ? "${var.keycloak_hostname}.${var.domain}" : "keycloak-${random_string.identifier.result}.${var.domain}"
  tags = {
    cost    = "shared"
    creator = "terraform"
    git     = var.git
  }
}

variable "aurora_max_capacity" {
  description = "https://www.terraform.io/docs/providers/aws/r/rds_cluster.html#max_capacity"
  type        = number
  default     = 10
}

variable "aurora_min_capacity" {
  description = "aurora cluster count"
  type        = number
  default     = 2
}

variable "metric_alarms_enabled" {
  description = "metric alarm enabled option"
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  description = "skip final snapshot"
  type        = bool
  default     = false
}

variable "protect" {
  description = "Enables deletion protection on eligible resources"
  type        = bool
  default     = true
}

variable "zone_id" {
  description = "Route53 Zone ID"
  type        = string
}

variable "domain" {
  description = "Route53 Domain"
  type        = string
}

variable "keycloak_hostname" {
  description = "Optional hostname for the keycloak server. If omitted a random identifier will be used."
  type        = string
  default     = "keycloak"
}

variable "vpc_id" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group#vpc_id"
  type        = string
}

variable "public_subnet_ids" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb#subnets"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster#subnet_ids"
  type        = list(string)
}

variable "certificate_arn" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener#certificate_arn"
  type        = string
}

variable "image_shared_keycloak" {
  description = "Docker image for keycloak"
  type        = string
  default     = "docker.io/champtitles/keycloak:6510cd46ae98c80ed81e6f0f05dbb13e143ec4eb"
}

variable "tags" {
  description = "Map of tags to assign to resources"
  type        = map(string)
  default     = {}
}

variable "app_max_capacity" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target#max_capacity"
  type        = number
  default     = 10
}

variable "app_min_capacity" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target#min_capacity"
  type        = number
  default     = 2
}

variable "cloudwatch_slack_url" {
  description = "channel to post error alert"
  type        = string
  default     = ""
}

variable "keycloak_admin_user" {
  description = "default keycloak admin user"
  type        = string
  default     = "admin"
}

variable "enable_lambda_cw_alert" {
  description = "enable lambda cw alert"
  type        = bool
  default     = false
}

variable "filter_pattern" {
  description = "https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/FilterAndPatternSyntax.html#extract-log-event-values"
  type        = string
  default     = ""
}

variable "git" {
  description = "Name of the Git repo"
  type        = string
  default     = "terraform-aws-keycloak"
}

variable "kc_loglevel" {
  description = "log level"
  type        = string
  default     = "INFO"
}

variable "proxy" {
  description = "https://www.keycloak.org/server/all-config#_proxy"
  type        = string
  default     = "edge"
}

variable "http_enabled" {
  description = "https://www.keycloak.org/server/all-config#_httptls"
  type        = bool
  default     = true
}

variable "hostname_strict_backchannel" {
  description = "https://www.keycloak.org/server/all-config#_httptls"
  type        = bool
  default     = true
}

variable "hostname_strict_https" {
  description = "https://www.keycloak.org/server/all-config#_httptls"
  type        = bool
  default     = false
}

variable "healthcheck_enabled" {
  description = "https://www.keycloak.org/server/all-config#_health"
  type        = bool
  default     = true
}

variable "kc_metrics_enabled" {
  description = "https://www.keycloak.org/server/all-config#_metrics"
  type        = bool
  default     = false
}

variable "jgroups_discovery_properties" {
  description = "jgroups discovery properties"
  type        = string
  default     = "datasource_jndi_name=java:jboss/datasources/KeycloakDS,info_writer_sleep_time=500,remove_old_coords_on_view_change=true"
}

variable "app_command" {
  description = "default command to run in ecs task definitions"
  type        = list(string)
  default     = ["start"]
}
