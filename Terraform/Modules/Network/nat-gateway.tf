resource "google_compute_router" "nat-router" {
  name    = "nat-router"
  network = google_compute_network.main-vpc.id
  region  = google_compute_subnetwork.managemet-subnet.region
}

resource "google_compute_router_nat" "public-nat" {
  name                   = "public-nat"
  router                 = google_compute_router.nat-router.name
  region                 = google_compute_router.nat-router.region
  nat_ip_allocate_option = "AUTO_ONLY"

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.managemet-subnet.name
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}
