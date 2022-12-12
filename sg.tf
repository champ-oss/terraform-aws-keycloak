resource "aws_security_group_rule" "jgroups" {
  type              = "ingress"
  from_port         = 7600
  to_port           = 7600
  protocol          = "tcp"
  cidr_blocks       = var.private_subnet_ids
  security_group_id = module.core.ecs_app_security_group
}