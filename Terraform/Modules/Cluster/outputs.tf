output "gke-master-cidr" {
  value = google_container_cluster.primary.private_cluster_config[0].master_ipv4_cidr_block
}
