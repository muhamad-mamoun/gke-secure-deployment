resource "google_compute_firewall" "restricted-firewall" {
  name    = "restricted-firewall"
  network = google_compute_network.main-vpc.name
  project = var.project

  deny {
    protocol = "all"
  }

  source_ranges      = [google_compute_subnetwork.restricted-subnet.ip_cidr_range]
  destination_ranges = ["0.0.0.0/0"]
  direction          = "EGRESS"
  priority           = 1000
}

resource "google_compute_firewall" "allow-egress-to-management" {
  name    = "allow-egress-to-management"
  network = google_compute_network.main-vpc.name
  project = var.project

  allow {
    protocol = "all"
  }

  source_ranges      = [google_compute_subnetwork.restricted-subnet.ip_cidr_range]
  destination_ranges = [google_compute_subnetwork.managemet-subnet.ip_cidr_range]
  direction          = "EGRESS"
  priority           = 900
}

resource "google_compute_firewall" "allow-artifact-egress" {
  name    = "allow-artifact-egress"
  network = google_compute_network.main-vpc.name
  project = var.project

  allow {
    protocol = "all"
  }

  destination_ranges = ["199.36.153.8/30", "199.36.153.4/30"]
  target_tags        = ["artifact-access-allowed"]
  direction          = "EGRESS"
  priority           = 800
}

resource "google_compute_firewall" "allow-iap-ssh" {
  name    = "allow-iap-ssh"
  network = google_compute_network.main-vpc.name
  project = var.project

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["35.235.240.0/20"]
  target_tags   = ["iap-accessible"]
  direction     = "INGRESS"
  priority      = 1000
}


resource "google_compute_firewall" "allow-nodes-to-master" {
  name    = "allow-gke-nodes-to-master"
  network = google_compute_network.main-vpc.name
  project = var.project


  allow {
    protocol = "all"
  }

  destination_ranges = [var.gke-master-cidr]
  target_tags        = ["master-access-allowed"]
  direction          = "EGRESS"
  priority           = 500
}

resource "google_compute_firewall" "allow-node-to-node" {
  name    = "allow-node-to-node"
  network = google_compute_network.main-vpc.name
  project = var.project

  allow {
    protocol = "all"
  }

  source_ranges      = [google_compute_subnetwork.restricted-subnet.ip_cidr_range]
  destination_ranges = [google_compute_subnetwork.restricted-subnet.ip_cidr_range]
  direction          = "INGRESS"
  priority           = 700
}

resource "google_compute_firewall" "allow-metadata-access" {
  name    = "allow-metadata-access"
  network = google_compute_network.main-vpc.name
  project = var.project

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges      = [google_compute_subnetwork.restricted-subnet.ip_cidr_range]
  destination_ranges = ["169.254.169.254/32"]
  direction          = "EGRESS"
  priority           = 600
}

resource "google_compute_firewall" "allow-dns" {
  name    = "allow-dns"
  network = google_compute_network.main-vpc.name
  project = var.project

  allow {
    protocol = "tcp"
    ports    = ["53"]
  }

  allow {
    protocol = "udp"
    ports    = ["53"]
  }

  source_ranges      = [google_compute_subnetwork.restricted-subnet.ip_cidr_range]
  destination_ranges = ["8.8.8.8/32", "8.8.4.4/32"]
  direction          = "EGRESS"
  priority           = 850
}
