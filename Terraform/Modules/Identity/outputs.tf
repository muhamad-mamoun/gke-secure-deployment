output "cluster-service-account" {
  value = google_service_account.cluster-service-account.email
}

output "management-service-account" {
  value = google_service_account.management-service-account.email
}
