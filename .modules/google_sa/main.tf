###########################################################################################
# Google Project Module based resources on: 
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account_key
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
variable "project_id" {
  type        = string
  description = "The ID of the project that the service account will be created in."
}

variable "display_name" {
  type        = string
  description = "The display name for the service account."
}

variable "account_id" {
  type        = string
  description = "The account id that is used to generate the service account email address and a stable unique id."
}

variable "description" {
  type        = string
  description = "A text description of the service account."
  default     = null
}

variable "disabled" {
  type        = bool
  description = "Whether a service account is disabled or not."
  default     = false
}

variable "generate_sa_key" {
  type        = bool
  description = "Whether a service account key should be created or not."
  default     = true
}

##################################################
#####               Resources                #####
##################################################
resource "google_service_account" "mod_google_service_account" {
  project      = var.project_id
  account_id   = var.account_id
  display_name = var.display_name
  description  = var.description
  disabled     = var.disabled
}

# note this requires the terraform to be run regularly
resource "time_rotating" "helper_time_rotation" {
  for_each      = toset(var.generate_sa_key ? ["create"] : [])
  rotation_days = 30
}

resource "google_service_account_key" "mod_google_service_account_key" {
  for_each           = toset(var.generate_sa_key ? ["create"] : [])
  service_account_id = google_service_account.mod_google_service_account.name
  keepers = {
    rotation_time = time_rotating.helper_time_rotation["create"].rotation_rfc3339
  }
}

##################################################
#####                Outputs                 #####
##################################################
output "id" {
  value       = google_service_account.mod_google_service_account.id
  description = "an identifier for the resource with format projects/{{project}}/serviceAccounts/{{email}}."
}

output "member" {
  value       = google_service_account.mod_google_service_account.member
  description = "The Identity of the service account in the form serviceAccount:{email}."
}

output "private_key" {
  value       = try(google_service_account_key.mod_google_service_account_key["create"].private_key, null)
  description = "The private key in JSON format, base64 encoded."
}