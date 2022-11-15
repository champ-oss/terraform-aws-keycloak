locals {
  dns_name = {
    shared_keycloak = "${trimprefix(var.git, "env-")}.${var.domain}"
  }
  tags = {
    cost    = "shared"
    creator = "terraform"
    git     = var.git
  }
}

variable "zone_id" {
  description = "Route53 Zone ID"
  type        = string
}

variable "domain" {
  description = "Route53 Domain"
  type        = string
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
  default     = "quay.io/keycloak/keycloak:20.0.1"
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

variable "aurora_max_capacity" {
  description = "https://www.terraform.io/docs/providers/aws/r/rds_cluster.html#max_capacity"
  type        = number
  default     = 8
}

variable "aurora_min_capacity" {
  description = "aurora cluster count"
  type        = number
  default     = 2
}

variable "cloudwatch_slack_url" {
  description = "channel to post error alert"
  type        = string
  default     = ""
}

variable "db_vendor" {
  description = "db_vendor"
  type        = string
  default     = "mysql"
}

variable "keycloak_user" {
  description = "default keycloak user"
  type        = string
  default     = "shared-keycloak"
}

variable "protect" {
  description = "Enables deletion protection on eligible resources"
  type        = bool
  default     = true
}

variable "skip_final_snapshot" {
  description = "skip final snapshot"
  type        = bool
  default     = false
}

variable "enable_lambda_cw_alert" {
  description = "skip final snapshot"
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
