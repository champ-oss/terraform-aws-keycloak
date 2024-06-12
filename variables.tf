locals {
  tags = {
    cost    = "shared"
    creator = "terraform"
    git     = var.git
  }
}

variable "kc_aurora_max_capacity" {
  description = "https://www.terraform.io/docs/providers/aws/r/rds_cluster.html#max_capacity"
  type        = number
  default     = 8
}

variable "kc_aurora_min_capacity" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#min_capacity"
  type        = number
  default     = 0.5
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
  description = "Docker image for keycloak, currently using 20.0.3"
  type        = string
  default     = "docker.io/champtitles/keycloak:b7b112c706263f79a3d96ad2590b0d2fa69994cc"
}

variable "tags" {
  description = "Map of tags to assign to resources"
  type        = map(string)
  default     = {}
}

variable "app_max_capacity" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target#max_capacity"
  type        = number
  default     = 20
}

variable "app_min_capacity" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target#min_capacity"
  type        = number
  default     = 1
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

variable "app_command" {
  description = "default command to run in ecs task definitions"
  type        = list(string)
  default     = ["start"]
}

variable "enable_cluster" {
  description = "enable or disable keycloak and db cluster"
  default     = true
  type        = bool
}

variable "create_dms_endpoint" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_endpoint"
  type        = bool
  default     = false
}

variable "dms_endpoint_type" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_endpoint#endpoint_type"
  type        = string
  default     = "source"
}

variable "autoscaling_target_value" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target#scalable_dimension"
  type        = number
  default     = 100
}

variable "ecs_keycloak_cpu" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition#cpu"
  type        = number
  default     = 1024
}

variable "ecs_keycloak_memory" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition#memory"
  type        = number
  default     = 2048
}

variable "kc_aurora_identifier_prefix" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#identifier"
  type        = string
  default     = "keycloak"
}

variable "kc_aurora_cluster_instance_count" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance"
  type        = number
  default     = 1
}

variable "alarms_email" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription#endpoint"
  type        = string
  default     = null
}

variable "aurora_shared_accounts" {
  description = "AWS accounts to share the RDS cluster"
  type        = list(string)
  default     = []
}

variable "source_cluster_identifier" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#source_cluster_identifier"
  type        = string
  default     = null
}

variable "db_cluster_parameter_group_name" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#db_cluster_parameter_group_name"
  type        = string
  default     = null
}

variable "kc_db_snapshot_identifier" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#snapshot_identifier"
  type        = string
  default     = null
}

variable "kc_app_name" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service#name"
  type        = string
  default     = "keycloak"
}