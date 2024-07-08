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
| [aws_cloudwatch_log_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_log_group_name"></a> [log\_group\_name](#input\_log\_group\_name) | Name for log group | `string` | `"pantori-default"` | no |
| <a name="input_log_group_retention"></a> [log\_group\_retention](#input\_log\_group\_retention) | Log group retention in days | `number` | `1` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_log_group_name"></a> [log\_group\_name](#output\_log\_group\_name) | n/a |
<!-- END_TF_DOCS -->