###########################################################################################
# Google Project Module based resources on: 
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project
###########################################################################################

##################################################
#####           Required Providers           #####
##################################################
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">=4.0, < 5.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">=4.0, < 5.0"
    }
  }
}

##################################################
#####               Variables                #####
##################################################
variable "id" {
  type        = string
  description = "ID of the group. For Google-managed entities, the ID must be the email address the group"
}

variable "customer_id" {
  type        = string
  description = "Customer ID of the organization to create the group in."
}

variable "display_name" {
  type        = string
  description = "The display name of the Group."
  default     = ""
}

variable "description" {
  type        = string
  description = "An extended description to help users determine the purpose of a Group."
  default     = ""
}

variable "initial_group_config" {
  type        = string
  description = "The initial configuration options for creating a Group."
  default     = "EMPTY"
}

variable "membership" {
  type = list(object({
    role    = string
    members = list(string)
  }))
  description = "Structured list of members by role, roles accepted: MEMBER, MANAGER and OWNER"
  default     = []
  validation {
    condition = length([
      for r in var.membership : true
      if contains(["MEMBER", "MANAGER", "OWNER"], r.role)
    ]) == length(var.membership)
    error_message = "All membership must have role of either MEMBER, MANAGER or OWNER."
  }
  validation {
    condition = length([
      for r in var.membership : true
      if length(r.members) > 0
    ]) == length(var.membership)
    error_message = "If provide a membership role, member list must contain at least 1 member."
  }
}

##################################################
#####                 Locals                 #####
##################################################
locals {
  # The order of roles should not be changed on the map.
  role_map = {
    OWNER   = ["OWNER", "MEMBER"]
    MANAGER = ["MEMBER", "MANAGER"]
    MEMBER  = ["MEMBER"]
  }
}

##################################################
#####               Resources                #####
##################################################
resource "google_cloud_identity_group" "mod_google_group" {
  provider     = google-beta
  display_name = var.display_name
  description  = var.description

  parent = "customers/${var.customer_id}"

  initial_group_config = var.initial_group_config

  group_key {
    id = var.id
  }

  labels = {
    "cloudidentity.googleapis.com/groups.discussion_forum" = ""
  }
}


resource "google_cloud_identity_group_membership" "mod_google_group_membership" {
  for_each = { for ms in var.membership : ms.role => ms }

  provider = google-beta
  group    = google_cloud_identity_group.mod_google_group.id

  dynamic "preferred_member_key" {
    for_each = each.value.members
    content {
      id = preferred_member_key.value
    }
  }

  dynamic "roles" {
    for_each = lookup(local.role_map, each.value.role)
    content {
      name = roles.value
    }
  }
}

##################################################
#####                Outputs                 #####
##################################################
output "id" {
  value       = google_cloud_identity_group.mod_google_group.group_key[0].id
  description = "ID of the group. For Google-managed entities, the ID is the email address the group"
}

output "resource_name" {
  value       = google_cloud_identity_group.mod_google_group.name
  description = "Resource name of the group in the format: groups/{group_id}, where group_id is the unique ID assigned to the group."
}

output "member" {
  value       = "group:${google_cloud_identity_group.mod_google_group.group_key[0].id}"
  description = "ID of the group as member. group:{group_id}"
}