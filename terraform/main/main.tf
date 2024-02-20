terraform {
  backend "local" {}
}

# terraform {
#   backend "gcs" {
#     bucket  = "tf-state-dev"
#     prefix  = "terraform/state"
#   }
# }

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

module "storage" {
  source = "../modules/storage"

  project_id = var.project_id
  region     = var.region
}

module "function" {
  source = "../modules/function"

  project_id           = var.project_id
  region               = var.region
  function_bucket_name = module.storage.function_bucket_name
}
