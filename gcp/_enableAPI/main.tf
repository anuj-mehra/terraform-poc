
resource "google_project_service" "vertex_ai" {
  project = var.project_id
  service = "aiplatform.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "vertex_gemini" {
  project = var.project_id
  service = "generativelanguage.googleapis.com"
  disable_on_destroy = false
}