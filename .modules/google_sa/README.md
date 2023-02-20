<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | >=4.43.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >=4.43.0 |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_service_account.mod_google_service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_key.mod_google_service_account_key](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_key) | resource |
| [time_rotating.helper_time_rotation](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | The account id that is used to generate the service account email address and a stable unique id. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | A text description of the service account. | `string` | `null` | no |
| <a name="input_disabled"></a> [disabled](#input\_disabled) | Whether a service account is disabled or not. | `bool` | `false` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name for the service account. | `string` | n/a | yes |
| <a name="input_generate_sa_key"></a> [generate\_sa\_key](#input\_generate\_sa\_key) | Whether a service account key should be created or not. | `bool` | `true` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the project that the service account will be created in. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | an identifier for the resource with format projects/{{project}}/serviceAccounts/{{email}}. |
| <a name="output_member"></a> [member](#output\_member) | The Identity of the service account in the form serviceAccount:{email}. |
| <a name="output_private_key"></a> [private\_key](#output\_private\_key) | The private key in JSON format, base64 encoded. |
<!-- END_TF_DOCS -->