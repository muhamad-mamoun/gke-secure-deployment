output "management-instance-ip" {
  value = google_compute_instance.management-instance.network_interface[0].network_ip
}
