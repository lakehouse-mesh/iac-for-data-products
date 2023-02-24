##################################################
#####           Required Providers           #####
#####            and Backend Init            #####
##################################################
terraform {
  backend "gcs" {
  }
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

  validation {
    condition     = fileexists("./config/${var.data_product}.yaml")
    error_message = "Configuration file for data product ${var.data_product} not found"
  }
}

##################################################
#####       Call Data Product Factory        #####
##################################################
module "dp_factory" {
  source = "../compositions/data_product_factory"

  data_product = yamldecode(file("${path.module}/config/${var.data_product}.yaml"))
  system       = var.system

  providers = {
    github      = github
    google      = google
    google-beta = google-beta
  }
}