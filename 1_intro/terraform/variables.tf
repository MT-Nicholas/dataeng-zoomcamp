locals {
  data_lake_bucket = "dtc_data_lake"  # this variable has no purpose other than to show the use of a local variables
}

variable "project" {
  description = "Your GCP Project ID"
  default = "dtc-de-412818"
  type = string
}

variable "region" {
  description = "Region for GCP resources. Choose as per your location: https://cloud.google.com/about/locations"
  default = "europe-west6"
  type = string
}

variable "storage_class" {
  description = "Storage class type for your bucket. Check official docs for more info."
  default = "STANDARD"
}

variable "BQ_DATASET" {
  description = "BigQuery Dataset that raw data (from GCS) will be written to"
  type = string
  default = "trips_data_all"
}

# # Transfer service
# variable "access_key_id" {
#   description = "AWS access key"
#   type = string
# }

# variable "aws_secret_key" {
#   description = "AWS secret key"
#   type = string
# }