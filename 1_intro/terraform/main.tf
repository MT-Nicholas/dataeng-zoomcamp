terraform {
  required_version = ">= 1.0"  # The minimum Terraform version to be used.
  backend "local" {}  # where to store the `.tfstate` of the infrastructure; can change from "local" to "gcs" (for google) or "s3" (for aws), if you would like to preserve your tf-state online
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">=3.5.0"
    }
  }
}


provider "google" {
  project = var.project
  region = var.region
#   credentials = file(var.credentials) # Use the credentials parameter if you do not want to set env-var GOOGLE_APPLICATION_CREDENTIALS;  by default, Terraform checks this env-var first
}

# Data Lake Bucket; Ref: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket
resource "google_storage_bucket" "data-lake-bucket" {
  name          = "${local.data_lake_bucket}_${var.project}" # Concatenating DL bucket & Project name for unique naming; notice syntax using {} and $
  location      = var.region

  # Optional, but recommended settings:
  storage_class = var.storage_class
  uniform_bucket_level_access = true

  versioning {
    enabled     = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 30  // days
    }
  }

  force_destroy = true
}

# DWH; Ref: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_dataset
resource "google_bigquery_dataset" "dataset" {
  dataset_id = var.BQ_DATASET
  project    = var.project
  location   = var.region
}
