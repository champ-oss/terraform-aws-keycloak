module "aurora" {
  source                          = "github.com/champ-oss/terraform-aws-aurora.git?ref=v1.0.55-ed51e39"
  cluster_identifier_prefix       = var.kc_aurora_identifier_prefix
  private_subnet_ids              = var.private_subnet_ids
  vpc_id                          = var.vpc_id
  source_security_group_id        = var.source_security_group_id
  tags                            = merge(local.tags, var.tags)
  cluster_instance_count          = var.kc_aurora_cluster_instance_count
  min_capacity                    = var.kc_aurora_min_capacity
  max_capacity                    = var.kc_aurora_max_capacity
  metric_alarms_enabled           = var.metric_alarms_enabled
  alarms_email                    = var.alarms_email
  shared_accounts                 = var.aurora_shared_accounts
  source_cluster_identifier       = var.source_cluster_identifier
  performance_insights_enabled    = false
  skip_final_snapshot             = var.skip_final_snapshot
  db_cluster_parameter_group_name = var.db_cluster_parameter_group_name
  snapshot_identifier             = var.kc_db_snapshot_identifier
  git                             = var.git
  protect                         = var.protect
  create_dms_endpoint             = var.create_dms_endpoint
  dms_endpoint_type               = var.dms_endpoint_type
}
