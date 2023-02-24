###########################################################################################
# GitHub Repository Module based resources on: 
# https://registry.terraform.io/providers/integrations/github/latest/docs
###########################################################################################

##################################################
#####           Required Providers           #####
##################################################
terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = ">=5.8"
    }
  }
}

##################################################
#####               Variables                #####
##################################################
variable "repository_name" {
  type        = string
  description = "The name of the repository. (it is usually data product name)"
}

variable "description" {
  type        = string
  description = "A description of the repository. (it not informed, repository will assume a default description)"
  default     = null
}

variable "visibility" {
  type        = string
  description = "Repository visibility, can be public or private."
  default     = "private"
  validation {
    condition     = contains(["public", "private"], var.visibility)
    error_message = "${var.visibility} value provided, acceptable values (public or private)"
  }
}

variable "template" {
  type = object({
    owner                = string
    repository           = string
    include_all_branches = bool
  })
  description = "Repository template to create resource."
  default     = null
}

variable "contributors" {
  type = list(object({
    type        = string
    contributor = string
    permission  = string
  }))
  description = "Contributors List (type, contributor, permission)"
  default     = []
  validation {
    condition = length([
      for c in var.contributors : c if contains(["user", "team"], c.type)
    ]) == length(var.contributors)

    error_message = "Error: one or more contributor type are misnamed, acceptable values (user or team)"
  }
}

##################################################
#####               Resources                #####
##################################################
resource "github_repository" "mod_github_repository" {
  name        = var.repository_name
  description = var.description == null ? "Github repository for code version of ${var.repository_name}" : var.description
  visibility  = var.visibility

  dynamic "template" {
    for_each = var.template == null ? [] : [1]
    content {
      owner                = var.template.owner
      repository           = var.template.repository
      include_all_branches = var.template.include_all_branches
    }
  }
}

resource "github_repository_collaborator" "mod_github_repository_collaborator" {
  for_each = { for uc in var.contributors : uc.contributor => uc if uc.type == "user" }

  repository = github_repository.mod_github_repository.name
  username   = each.value.contributor
  permission = each.value.permission
}

resource "github_team_repository" "mod_github_team_repository" {
  for_each = { for tc in var.contributors : tc.contributor => tc if tc.type == "team" }

  repository = github_repository.mod_github_repository.name
  team_id    = each.value.contributor
  permission = each.value.permission
}

##################################################
#####                Outputs                 #####
##################################################
output "id" {
  value       = github_repository.mod_github_repository.repo_id
  description = "GitHub ID for the repository."
}

output "git_clone_url" {
  value       = github_repository.mod_github_repository.git_clone_url
  description = "URL that can be provided to git clone to clone the repository anonymously via the git protocol."
}

output "full_name" {
  value       = github_repository.mod_github_repository.full_name
  description = "A string of the form 'orgname/reponame'."
}

output "name" {
  value       = github_repository.mod_github_repository.name
  description = "A string of the form 'reponame'."
}

