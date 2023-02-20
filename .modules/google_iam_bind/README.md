<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | >=4.43.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >=4.43.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_project_iam_binding.mod_google_iam](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_binding) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_binds"></a> [binds](#input\_binds) | n/a | <pre>list(object({<br>    roles   = list(string)<br>    members = list(string)<br>  }))</pre> | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | The project id of the target project. This is not inferred from the provider. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_binded"></a> [binded](#output\_binded) | ################################################# ####                Outputs                 ##### ################################################# |
<!-- END_TF_DOCS -->