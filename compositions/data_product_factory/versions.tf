##################################################
#####           Required Providers           #####
##################################################
terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "5.9.0"
    }
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