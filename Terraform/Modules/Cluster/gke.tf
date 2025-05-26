resource "google_container_cluster" "primary" {
  name                     = "my-gke-cluster"
  location                 = "${var.region}-a"
  remove_default_node_pool = true
  initial_node_count       = 2
  deletion_protection      = false

  network    = var.main-vpc-name
  subnetwork = var.restricted-subnet

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "${var.management-instance-ip}/32"
      display_name = "Management Instance"
    }

    cidr_blocks {
      cidr_block   = "${var.my-public-ip}/32"
      display_name = "My own public IP"
    }
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }
}

resource "google_container_node_pool" "custom-node-pool" {
  name     = "custom-node-pool"
  location = "${var.region}-a"

  cluster    = google_container_cluster.primary.name
  node_count = 2

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    disk_size_gb = 15
    preemptible  = true
    machine_type = "e2-medium"
    tags         = ["artifact-access-allowed", "iap-accessible", "master-access-allowed"]

    service_account = var.cluster-service-account
    oauth_scopes    = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}
