<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_github"></a> [github](#requirement\_github) | 5.9.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | 4.47.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | 4.47.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dp_factory"></a> [dp\_factory](#module\_dp\_factory) | ../compositions/data_product_factory | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_data_product"></a> [data\_product](#input\_data\_product) | Data Product to be created or updated | `string` | n/a | yes |
| <a name="input_system"></a> [system](#input\_system) | Recieve map of variables common for all data product (e.g: organization, environment...) | `map(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->