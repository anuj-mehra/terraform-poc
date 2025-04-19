# Creation of GCP Buckets

resource "google_storage_bucket" "palace-accounting" {
  name          = "palace-accounting"
  location      = var.region
  storage_class = "STANDARD"
  uniform_bucket_level_access = true  # Enforce IAM policies
}

resource "google_storage_bucket_object" "bin" {
  name   = "bin/"  # Folder name (must end with `/`)
  bucket = google_storage_bucket.palace-accounting.name
  content = "\n"  # Minimum required content (cannot be empty)
}

resource "google_storage_bucket_object" "conf" {
  name  = "conf/"  # Folder name (must end with `/`)
  bucket = google_storage_bucket.palace-accounting.name
  content = "\n"  # Minimum required content (cannot be empty)
}

# IAM Binding with Condition (Grants Access to the "conf/" Folder)
resource "google_storage_bucket_iam_binding" "conf_folder_access" {
  bucket = google_storage_bucket.palace-accounting.name
  role   = "roles/storage.objectViewer"  # Change role as needed

  members = [
    "${var.service_account_prefix}sa-devops${var.service_account_domain}",
    "${var.service_account_prefix}sa-monitoring${var.service_account_domain}",
  ]

  condition {
    title       = "Allow access to conf folder"
    description = "Restrict access to objects under conf/"
    expression  = "resource.name.startsWith('projects/_/buckets/${google_storage_bucket.palace-accounting.name}/objects/conf/')"
  }
}
