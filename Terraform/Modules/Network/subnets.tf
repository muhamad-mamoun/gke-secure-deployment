resource "google_compute_subnetwork" "managemet-subnet" {
  network       = google_compute_network.main-vpc.id
  name          = "managemet-subnet"
  ip_cidr_range = "10.32.0.0/16"
  region        = var.region

  private_ip_google_access = true
}

resource "google_compute_subnetwork" "restricted-subnet" {
  network       = google_compute_network.main-vpc.id
  name          = "restricted-subnet"
  ip_cidr_range = "10.33.0.0/16"
  region        = var.region

  private_ip_google_access = true
}
