module "aurora" {
  source                    = "github.com/champ-oss/terraform-aws-aurora.git?ref=v1.0.27-26f5fd1"
  cluster_identifier_prefix = var.git
  private_subnet_ids        = var.private_subnet_ids
  vpc_id                    = var.vpc_id
  source_security_group_id  = module.core.ecs_app_security_group
  tags                      = merge(local.tags, var.tags)
  cluster_instance_count    = var.aurora_min_capacity
  max_capacity              = var.aurora_max_capacity
  metric_alarms_enabled     = var.metric_alarms_enabled
  skip_final_snapshot       = var.skip_final_snapshot
  protect                   = var.protect
}
