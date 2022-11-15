# terraform-aws-keycloak

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.30.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.30.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aurora_keycloak"></a> [aurora\_keycloak](#module\_aurora\_keycloak) | github.com/champ-oss/terraform-aws-aurora.git | v1.0.19-099cab0 |
| <a name="module_core"></a> [core](#module\_core) | github.com/champ-oss/terraform-aws-core.git | v1.0.2-b320aca |
| <a name="module_shared_keycloak"></a> [shared\_keycloak](#module\_shared\_keycloak) | github.com/champ-oss/terraform-aws-app.git | v1.0.169-2247a4d |

## Resources

| Name | Type |
|------|------|
| [aws_ssm_parameter.shared_keycloak](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [random_password.shared_keycloak](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_string.identifier](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_max_capacity"></a> [app\_max\_capacity](#input\_app\_max\_capacity) | https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target#max_capacity | `number` | `10` | no |
| <a name="input_app_min_capacity"></a> [app\_min\_capacity](#input\_app\_min\_capacity) | https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target#min_capacity | `number` | `2` | no |
| <a name="input_aurora_max_capacity"></a> [aurora\_max\_capacity](#input\_aurora\_max\_capacity) | https://www.terraform.io/docs/providers/aws/r/rds_cluster.html#max_capacity | `number` | `8` | no |
| <a name="input_aurora_min_capacity"></a> [aurora\_min\_capacity](#input\_aurora\_min\_capacity) | aurora cluster count | `number` | `2` | no |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener#certificate_arn | `string` | n/a | yes |
| <a name="input_cloudwatch_slack_url"></a> [cloudwatch\_slack\_url](#input\_cloudwatch\_slack\_url) | channel to post error alert | `string` | `""` | no |
| <a name="input_db_vendor"></a> [db\_vendor](#input\_db\_vendor) | db\_vendor | `string` | `"mysql"` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | Route53 Domain | `string` | n/a | yes |
| <a name="input_enable_lambda_cw_alert"></a> [enable\_lambda\_cw\_alert](#input\_enable\_lambda\_cw\_alert) | skip final snapshot | `bool` | `false` | no |
| <a name="input_filter_pattern"></a> [filter\_pattern](#input\_filter\_pattern) | https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/FilterAndPatternSyntax.html#extract-log-event-values | `string` | `""` | no |
| <a name="input_git"></a> [git](#input\_git) | Name of the Git repo | `string` | `"terraform-aws-keycloak"` | no |
| <a name="input_image_shared_keycloak"></a> [image\_shared\_keycloak](#input\_image\_shared\_keycloak) | Docker image for keycloak | `string` | `"quay.io/keycloak/keycloak:20.0.1"` | no |
| <a name="input_keycloak_hostname"></a> [keycloak\_hostname](#input\_keycloak\_hostname) | Optional hostname for the keycloak server. If omitted a random identifier will be used. | `string` | `"keycloak"` | no |
| <a name="input_keycloak_user"></a> [keycloak\_user](#input\_keycloak\_user) | default keycloak user | `string` | `"shared-keycloak"` | no |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster#subnet_ids | `list(string)` | n/a | yes |
| <a name="input_protect"></a> [protect](#input\_protect) | Enables deletion protection on eligible resources | `bool` | `true` | no |
| <a name="input_public_subnet_ids"></a> [public\_subnet\_ids](#input\_public\_subnet\_ids) | https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb#subnets | `list(string)` | n/a | yes |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | skip final snapshot | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to assign to resources | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group#vpc_id | `string` | n/a | yes |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | Route53 Zone ID | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->