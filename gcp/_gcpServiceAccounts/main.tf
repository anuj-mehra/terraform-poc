# Creation of Service Accountss

variable "service_accounts" {
  description = "List of service accounts to create"
  type        = list(string)
  default     = ["sa-terraform", "sa-devops", "sa-monitoring"]
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
