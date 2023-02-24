<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_github"></a> [github](#requirement\_github) | 5.9.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >=4.0, < 5.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | >=4.0, < 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | 5.9.0 |
| <a name="provider_google"></a> [google](#provider\_google) | >=4.0, < 5.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dp_github_repository"></a> [dp\_github\_repository](#module\_dp\_github\_repository) | ../../.modules/github_repository | n/a |
| <a name="module_dp_google_admnistrator_group"></a> [dp\_google\_admnistrator\_group](#module\_dp\_google\_admnistrator\_group) | ../../.modules/google_group | n/a |
| <a name="module_dp_google_developers_group"></a> [dp\_google\_developers\_group](#module\_dp\_google\_developers\_group) | ../../.modules/google_group | n/a |
| <a name="module_dp_google_iam_bind"></a> [dp\_google\_iam\_bind](#module\_dp\_google\_iam\_bind) | ../../.modules/google_iam_bind | n/a |
| <a name="module_dp_google_service_account"></a> [dp\_google\_service\_account](#module\_dp\_google\_service\_account) | ../../.modules/google_sa | n/a |

## Resources

| Name | Type |
|------|------|
| [github_actions_secret.dp_github_action_secrets](https://registry.terraform.io/providers/integrations/github/5.9.0/docs/resources/actions_secret) | resource |
| [google_project.dp_google_project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project) | resource |
| [google_storage_bucket.dp_google_storage](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [random_string.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [google_active_folder.dp_domain_google_folder](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/active_folder) | data source |
| [google_organization.dp_google_organization](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_data_product"></a> [data\_product](#input\_data\_product) | Data product object variable that hold parameters | <pre>object({<br>    name        = string<br>    domain      = string<br>    environment = optional(list(string), ["dev", "prod"])<br>    tech_lead_cred = optional(object({<br>      github = optional(string)<br>      google = optional(string)<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_system"></a> [system](#input\_system) | System environment variables passed through TF\_VARs parameter | <pre>object({<br>    environment         = string<br>    organization_id     = string<br>    organization_name   = string<br>    organization_prefix = string<br>    region              = string<br>    billing_account_id  = string<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_data_product_info"></a> [data\_product\_info](#output\_data\_product\_info) | ################################################# ####                Outputs                 ##### ################################################# |
<!-- END_TF_DOCS -->