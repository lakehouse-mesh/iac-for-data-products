<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_github"></a> [github](#requirement\_github) | >=5.8 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | >=5.8 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_repository.mod_github_repository](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |
| [github_repository_collaborator.mod_github_repository_collaborator](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_collaborator) | resource |
| [github_team_repository.mod_github_team_repository](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_repository) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_contributors"></a> [contributors](#input\_contributors) | Contributors List (type, contributor, permission) | <pre>list(object({<br>    type        = string<br>    contributor = string<br>    permission  = string<br>  }))</pre> | `[]` | no |
| <a name="input_description"></a> [description](#input\_description) | A description of the repository. (it not informed, repository will assume a default description) | `string` | `null` | no |
| <a name="input_repository_name"></a> [repository\_name](#input\_repository\_name) | The name of the repository. (it is usually data product name) | `string` | n/a | yes |
| <a name="input_template"></a> [template](#input\_template) | Repository template to create resource. | <pre>object({<br>    owner                = string<br>    repository           = string<br>    include_all_branches = bool<br>  })</pre> | `null` | no |
| <a name="input_visibility"></a> [visibility](#input\_visibility) | Repository visibility, can be public or private. | `string` | `"private"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_full_name"></a> [full\_name](#output\_full\_name) | A string of the form 'orgname/reponame'. |
| <a name="output_git_clone_url"></a> [git\_clone\_url](#output\_git\_clone\_url) | URL that can be provided to git clone to clone the repository anonymously via the git protocol. |
| <a name="output_id"></a> [id](#output\_id) | GitHub ID for the repository. |
<!-- END_TF_DOCS -->