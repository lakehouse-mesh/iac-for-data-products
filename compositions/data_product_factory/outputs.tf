##################################################
#####                Outputs                 #####
##################################################
output "data_product_info" {
  value = {
    repository     = try(module.dp_github_repository[var.system.environment].full_name, "")
    google_project = try(google_project.dp_google_project[var.system.environment].id, "")
    google_storage = try(google_storage_bucket.dp_google_storage[var.system.environment].url, "")
  }
}
