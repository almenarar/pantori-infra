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
| [aws_ecr_repository.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Repository name | `string` | `"pantori-default"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Repository tags | `map(string)` | <pre>{<br>  "Environment": "default",<br>  "Name": "default",<br>  "Onwer": "pantori-default"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_image_name"></a> [image\_name](#output\_image\_name) | n/a |
<!-- END_TF_DOCS -->