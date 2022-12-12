resource "aws_security_group_rule" "jgroups" {
  type              = "group access"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  self              = true
  security_group_id = module.core.ecs_app_security_group
}