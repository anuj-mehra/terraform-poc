# Define variables to be used

variable "project_id" {
  description = "GCP Project Id"
  type        = string
  default     = "spatial-edition-256713"
}

variable "region" {
  description = "GCP region to deploy resources"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "GCP zone to deploy resources"
  type        = string
  default     = "us-central1-c"
}

variable "credentials_file" {
  description = "Path to GCP Service Account JSON key"
  type        = string
  default     = "./terraform-sa-key.json" # Ensure this file exists in your working directory
}


