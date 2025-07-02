# Creation of Service Accountss

variable "service_accounts" {
  description = "List of service accounts to create"
  type        = list(string)
  default     = ["sa-terraform", "sa-devops", "sa-monitoring", "sa-cloudrun", "sa-composer"]
}

# Create multiple service accounts
resource "google_service_account" "sa" {
  for_each    = toset(var.service_accounts)
  account_id  = each.value
  display_name = "Service Account ${each.value}"
}

# Assign IAM roles to each service account
resource "google_project_iam_member" "sa_roles" {
  for_each = google_service_account.sa

  project = var.project_id
  role    = "roles/editor"  # Change role as needed
  member  = "serviceAccount:${each.value.email}"
}

# Output the service account email IDs
output "service_account_emails" {
  value = [for sa in google_service_account.sa : sa.email]
}



// Service accounts for Vertex AI
resource "google_service_account" "gemini_sa" {
  account_id   = "gemini-api-caller"
  display_name = "Service Account for Gemini API Access"
}

# Attach IAM roles required for Vertex AI Gemini
resource "google_project_iam_member" "vertex_ai_user" {
  project = var.project_id
  role    = "roles/aiplatform.user"
  member  = "serviceAccount:${google_service_account.gemini_sa.email}"
}

resource "google_project_iam_member" "vertex_generative_ai_user" {
  project = var.project_id
  role    = "roles/aiplatform.admin"  # Optional: For broader access
  member  = "serviceAccount:${google_service_account.gemini_sa.email}"
}

/*resource "google_project_iam_member" "gemini_api_access" {
  project = var.project_id
  role    = "roles/aiplatform.generalUser"
  member  = "serviceAccount:${google_service_account.gemini_sa.email}"
}*/

# Create a service account key
resource "google_service_account_key" "key" {
  service_account_id = google_service_account.gemini_sa.name
  private_key_type   = "TYPE_GOOGLE_CREDENTIALS_FILE"
}

