# only call provide, configurantion for provider 
# will be through environment variables
provider "github" {
}

provider "google" {
}

provider "google-beta" {
  user_project_override = true
}
