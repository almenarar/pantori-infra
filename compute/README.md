<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecs_service.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_lb.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster"></a> [cluster](#input\_cluster) | ECS cluster to include the service | `string` | `"pantori-default"` | no |
| <a name="input_container_count"></a> [container\_count](#input\_container\_count) | Number of desired containers | `number` | `1` | no |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | Amount of CPU per container | `string` | `"256"` | no |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | Environment variables for the container, don`t include sensible data here` | `list(map(string))` | <pre>[<br>  {<br>    "name": "name",<br>    "value": "value"<br>  }<br>]</pre> | no |
| <a name="input_has_secrets"></a> [has\_secrets](#input\_has\_secrets) | n/a | `bool` | `false` | no |
| <a name="input_image_name"></a> [image\_name](#input\_image\_name) | Container image name | `string` | `"pantori-default"` | no |
| <a name="input_is_web_faced"></a> [is\_web\_faced](#input\_is\_web\_faced) | Set true to create a loadbalance with public endpoint | `bool` | `false` | no |
| <a name="input_log_group_name"></a> [log\_group\_name](#input\_log\_group\_name) | n/a | `any` | n/a | yes |
| <a name="input_memory"></a> [memory](#input\_memory) | Amount of memory per container | `string` | `"512"` | no |
| <a name="input_port"></a> [port](#input\_port) | Container/Host port to open | `number` | `80` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | n/a | `list(string)` | n/a | yes |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | n/a | `list(string)` | n/a | yes |
| <a name="input_role_arn"></a> [role\_arn](#input\_role\_arn) | n/a | `string` | n/a | yes |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | Sensible environment variables for the container | `list(map(string))` | n/a | yes |
| <a name="input_security_group_alb"></a> [security\_group\_alb](#input\_security\_group\_alb) | n/a | `any` | n/a | yes |
| <a name="input_security_group_ecs"></a> [security\_group\_ecs](#input\_security\_group\_ecs) | n/a | `any` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Service name | `string` | `"pantori-default"` | no |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | n/a | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->