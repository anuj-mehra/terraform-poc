output "service_account_email" {
  value = google_service_account.gemini_sa.email
}

output "service_account_key_json" {
  value     = google_service_account_key.key.private_key
  sensitive = true
}
