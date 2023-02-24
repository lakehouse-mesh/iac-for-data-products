
###########################################################################################
# Data product compositions module: 
#   Google:
#       Project: Create google project, base for data product
#         Group: Create google groups to manage access to data product
#       Storage: Create google storage to store objects (data, credentials, config files...)
#            SA: Create google service account, only one with access in PROD environment
#      IAM Bind: Create bind between project roles x groups
#   Github:
#       Repository: Create repository based on template and manage collaborators
#          Actions: Add workflows for CI/CD based on template
#    Crededentials: Add secret for action secret recieved (e.g. SA credentials)
###########################################################################################


##################################################
#####              Data Sources              #####
##################################################
data "google_organization" "dp_google_organization" {
  domain = var.system.organization_name
}

data "google_active_folder" "dp_domain_google_folder" {
  display_name = var.data_product.domain
  parent       = data.google_organization.dp_google_organization.name
}


##################################################
#####                 Helpers                #####
##################################################
# random suffix to ensure uniqueness
resource "random_string" "suffix" {
  special = false
  upper   = false
  length  = 4
}

##################################################
#####              Modules Call              #####
##################################################
# Google Modules
# google project resource was not modularized, there is not need for that
resource "google_project" "dp_google_project" {
  for_each = toset(local.environment_optout ? [] : [var.system.environment])

  name       = "${var.data_product.name}-${var.system.environment}"
  project_id = "${var.system.organization_prefix}-${var.data_product.name}-${var.system.environment}"
  folder_id  = data.google_active_folder.dp_domain_google_folder.name
  provider   = google

  billing_account = var.system.billing_account_id
}



# google storage bucket was not modularized, there is not need for that
resource "google_storage_bucket" "dp_google_storage" {
  for_each = toset(local.environment_optout ? [] : [var.system.environment])

  name                        = "${var.data_product.name}-${var.system.region}-${var.system.environment}-${random_string.suffix.result}"
  location                    = var.system.region
  project                     = google_project.dp_google_project[var.system.environment].project_id
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"
  provider                    = google
}

module "dp_google_developers_group" {
  for_each = toset(local.environment_optout ? [] : [var.system.environment])
  source   = "../../.modules/google_group"

  id           = "${var.data_product.name}-developers@${var.system.organization_name}"
  display_name = "${var.data_product.name}-developers"
  customer_id  = data.google_organization.dp_google_organization.directory_customer_id
  membership = [{
    role    = "MANAGER"
    members = [var.data_product.tech_lead_cred.google]
  }]

  depends_on = [
    google_project.dp_google_project
  ]

  providers = {
    google = google-beta
  }
}

module "dp_google_admnistrator_group" {
  for_each = toset(local.environment_optout ? [] : [var.system.environment])
  source   = "../../.modules/google_group"

  id           = "${var.data_product.name}-admnistrators@${var.system.organization_name}"
  display_name = "${var.data_product.name}-admnistrators"
  customer_id  = data.google_organization.dp_google_organization.directory_customer_id

  membership = [{
    role    = "MEMBER"
    members = [var.data_product.tech_lead_cred.google]
  }]

  depends_on = [
    google_project.dp_google_project
  ]

  providers = {
    google = google-beta
  }
}

module "dp_google_service_account" {
  for_each = toset(local.environment_optout ? [] : [var.system.environment])
  source   = "../../.modules/google_sa"

  project_id   = google_project.dp_google_project[var.system.environment].number
  account_id   = "${var.data_product.name}-svc-${var.system.environment}"
  display_name = "${var.data_product.name}-svc-${var.system.environment}"

  depends_on = [
    google_project.dp_google_project
  ]

  providers = {
    google = google
  }
}


module "dp_google_iam_bind" {
  for_each = toset(local.environment_optout ? [] : [var.system.environment])
  source   = "../../.modules/google_iam_bind"

  project = google_project.dp_google_project[var.system.environment].project_id
  binds = [
    {
      roles   = local.google_permission_profiles.developers
      members = [module.dp_google_developers_group[each.key].member]
    },
    {
      roles   = local.google_permission_profiles.administrators
      members = [module.dp_google_developers_group[each.key].member]
    },
    {
      roles   = local.google_permission_profiles.service_account
      members = [module.dp_google_service_account[each.key].member]
    }
  ]

  depends_on = [
    module.dp_google_developers_group,
    module.dp_google_admnistrator_group,
    module.dp_google_service_account
  ]

  providers = {
    google = google
  }
}


# Github Modules
module "dp_github_repository" {
  for_each = toset(local.environment_optout || local.github_optout ? [] : [var.system.environment])
  source   = "../../.modules/github_repository"

  repository_name = var.data_product.name
  visibility      = "public"
  contributors = var.data_product.tech_lead_cred.github == null ? [] : [{
    type        = "user"
    contributor = var.data_product.tech_lead_cred.github
    permission  = "admin"
  }]
  template = {
    owner                = "lakehouse-mesh"
    repository           = "data-product-template"
    include_all_branches = true
  }

  providers = {
    github = github
  }
}

resource "github_actions_secret" "dp_github_action_secrets" {
  for_each = toset(local.environment_optout || local.github_optout ? [] : [var.system.environment])

  repository        = module.dp_github_repository[var.system.environment].name
  secret_name       = "GCP_SA_CREDENTIALS"
  enencrypted_value = module.dp_google_service_account[var.system.environment].private_key

  depends_on = [
    module.dp_google_service_account
  ]

  provider = github
}


