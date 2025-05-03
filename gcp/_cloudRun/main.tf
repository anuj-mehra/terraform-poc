resource "google_service_account" "cloud_run_sa" {
  account_id   = "cloud-run-executor"
  display_name = "Cloud Run Service Account"
}

resource "google_artifact_registry_repository" "docker_repo" {
  name         = "cloud-run-repo"
  format       = "DOCKER"
  location     = var.region
  repository_id = "cloud-run-repo"
}

resource "google_cloud_run_service" "default" {
  name     = "hello-cloud-run"
  location = var.region

  template {
    spec {
      containers {
        image = "REGION-docker.pkg.dev/${var.project_id}/cloud-run-repo/hello-app:latest"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  autogenerate_revision_name = true
}

resource "google_project_iam_member" "cloud_run_sa_roles" {
  project = var.project_id
  role    = "roles/storage.admin"  # Example role
  member  = "serviceAccount:${google_service_account.cloud_run_sa.email}"
}

