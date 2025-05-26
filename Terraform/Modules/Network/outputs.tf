output "main-vpc-name" {
  value = google_compute_network.main-vpc.name
}

output "management-subnet" {
  value = google_compute_subnetwork.managemet-subnet.name
}

output "restricted-subnet" {
  value = google_compute_subnetwork.restricted-subnet.name
}
