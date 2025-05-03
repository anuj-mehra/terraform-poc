resource "google_service_account" "gce_sa" {
  account_id   = "gce-instance-sa"
  project = var.project_id
  display_name = "GCE Instance Service Account"
}

resource "google_project_iam_member" "sa_compute" {
  role   = "roles/compute.admin"
  project = var.project_id
  member = "serviceAccount:${google_service_account.gce_sa.email}"
}

resource "google_project_iam_member" "sa_network" {
  role   = "roles/compute.networkAdmin"
  project = var.project_id
  member = "serviceAccount:${google_service_account.gce_sa.email}"
}

resource "google_compute_network" "vpc_network" {
  name                    = "terraform-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "terraform-subnet"
  ip_cidr_range = "10.0.0.0/24"
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-vm"
  machine_type = "e2-medium"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.subnet.name
    access_config {}
  }

  service_account {
    email  = google_service_account.gce_sa.email
    scopes = ["cloud-platform"]
  }
}

output "instance_ip" {
  value = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
}
