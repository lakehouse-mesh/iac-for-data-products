##################################################
#####               Variables                #####
##################################################
variable "data_product" {
  type = object({
    name        = string
    domain      = string
    environment = optional(list(string), ["dev", "prod"])
    tech_lead_cred = optional(object({
      github = optional(string)
      google = optional(string)
    }))
  })
  description = "Data product object variable that hold parameters"
  validation {
    condition     = contains(var.data_product.environment, "dev")
    error_message = "Err: dev is mandatory in list of environemnt."
  }
  validation {
    condition     = can(regex("^[a-z](?:[-a-z0-9]{4,21})$", var.data_product.name))
    error_message = "data product name should respect follow regex: ^[a-z](?:[-a-z0-9]{4,21})$"
  }
}

variable "system" {
  type = object({
    environment         = string
    organization_id     = string
    organization_name   = string
    organization_prefix = string
    region              = string
  })
  description = "System environment variables passed through TF_VARs parameter"
}


##################################################
#####            Local Variables             #####
##################################################

# Optout variable for resources that needs to be created within specific environments
locals {
  environment_optout = !contains(var.data_product.environment, var.system.environment)
  github_optout      = !contains([["dev"], var.system.environment]) #Github repository is only created when run to DEV
}

# Resources to set role and permissions to Actors
# developers groups: BigQuery Data Owner, Dataflow Developer, Dataproc Editor, Storage Object Admin
# administrators groups: BigQuery Data Viewer, Service Usage Admin, Storage Object Viewer
# service account: BigQuery Data Owner, Dataflow Worker, Dataproc Worker, Storage Object Admin
locals {
  google_permission_profiles = {
    developers      = ["roles/bigquery.dataOwner", "roles/dataflow.developer", "roles/dataproc.editor", "roles/storage.objectAdmin"]
    administrators  = ["roles/bigquery.dataViewer", "roles/serviceusage.serviceUsageAdmin", "roles/storage.objectViewer"]
    service_account = ["roles/bigquery.dataOwner", "roles/dataflow.worker", "roles/dataproc.worker", "roles/storage.objectAdmin"]
  }
}