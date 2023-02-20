<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | >=4.0, < 5.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | >=4.0, < 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | >=4.0, < 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google-beta_google_cloud_identity_group.mod_google_group](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_cloud_identity_group) | resource |
| [google-beta_google_cloud_identity_group_membership.mod_google_group_membership](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_cloud_identity_group_membership) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_customer_id"></a> [customer\_id](#input\_customer\_id) | Customer ID of the organization to create the group in. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | An extended description to help users determine the purpose of a Group. | `string` | `""` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name of the Group. | `string` | `""` | no |
| <a name="input_id"></a> [id](#input\_id) | ID of the group. For Google-managed entities, the ID must be the email address the group | `string` | n/a | yes |
| <a name="input_initial_group_config"></a> [initial\_group\_config](#input\_initial\_group\_config) | The initial configuration options for creating a Group. | `string` | `"EMPTY"` | no |
| <a name="input_membership"></a> [membership](#input\_membership) | Structured list of members by role, roles accepted: MEMBER, MANAGER and OWNER | <pre>list(object({<br>    role    = string<br>    members = list(string)<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | ID of the group. For Google-managed entities, the ID is the email address the group |
| <a name="output_member"></a> [member](#output\_member) | ID of the group as member. group:{group\_id} |
| <a name="output_resource_name"></a> [resource\_name](#output\_resource\_name) | Resource name of the group in the format: groups/{group\_id}, where group\_id is the unique ID assigned to the group. |
<!-- END_TF_DOCS -->