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
      version = "4.47.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "4.47.0"
    }
  }
}

##################################################
#####               Variables                #####
##################################################
variable "system" {
  type        = map(string)
  description = "Recieve map of variables common for all data product (e.g: organization, environment...)"
}

variable "data_product" {
  type        = string
  description = "Data Product to be created or updated"
}


resource "random_string" "random" {
  length           = 16
  special          = true
  override_special = "/@£$"
}

