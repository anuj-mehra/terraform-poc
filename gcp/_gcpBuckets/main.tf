# Creation of GCP Buckets

resource "google_storage_bucket" "palace-accounting" {
  name          = "palace-accounting"
  location      = var.region
  storage_class = "STANDARD"
  uniform_bucket_level_access = true  # Enforce IAM policies
}

resource "google_storage_bucket_object" "bin" {
  display-name = "bin/"  # Folder name (must end with `/`)
  parent       = google_storage_bucket.palace-accounting.name
  content = ""  # Empty content to act as a folder placeholder
}

resource "google_storage_bucket_object" "conf" {
  display-name = "conf/"  # Folder name (must end with `/`)
  parent       = google_storage_bucket.palace-accounting.name
  content = ""  # Empty content to act as a folder placeholder
}