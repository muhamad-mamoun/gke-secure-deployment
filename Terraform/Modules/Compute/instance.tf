resource "google_compute_instance" "management-instance" {
  project                   = var.project
  zone                      = "${var.region}-a"
  name                      = "management-instance"
  machine_type              = "e2-medium"
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network    = var.vpc-name
    subnetwork = var.subnet-name
  }

  service_account {
    email  = var.management-service-account
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  tags = ["iap-accessible"]
}
