###########################################################################################
# Google IAM Module based resources on: 
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam#google_project_iam_binding
###########################################################################################

##################################################
#####           Required Providers           #####
##################################################
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">=4.43.0"
    }
  }
}

##################################################
#####               Variables                #####
##################################################
variable "project" {
  type        = string
  description = "The project id of the target project. This is not inferred from the provider."
}

variable "binds" {
  type = list(object({
    roles   = list(string)
    members = list(string)
  }))
}

##################################################
#####               Locals                #####
##################################################
locals {
  binded = flatten([
    for bind in var.binds : [
      for role in bind.roles : {
        role    = role
        members = bind.members
      }
    ]
  ])
}

##################################################
#####               Resources                #####
##################################################
resource "google_project_iam_binding" "mod_google_iam" {
  for_each = { for b in local.binded : b.role => b.members... }

  project = var.project
  role    = each.key

  members = each.value[0]
}


##################################################
#####                Outputs                 #####
##################################################
output "binded" {
  value = local.binded
}