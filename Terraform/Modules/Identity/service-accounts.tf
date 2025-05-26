resource "google_service_account" "cluster-service-account" {
  account_id   = "cluster-service-account"
  display_name = "cluster-service-account"
}

resource "google_project_iam_member" "gke_node_sa_permissions" {
  for_each = toset(["roles/container.nodeServiceAccount",
    "roles/compute.instanceAdmin.v1",
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/artifactregistry.reader",
  ])

  role    = each.key
  project = var.project
  member  = "serviceAccount:${google_service_account.cluster-service-account.email}"
}

resource "google_service_account" "management-service-account" {
  account_id   = "gke-management-service-account"
  display_name = "gke-management-service-account"
}

resource "google_project_iam_member" "gke_viewer" {
  for_each = toset(["roles/container.developer",
    "roles/container.clusterViewer",
    "roles/artifactregistry.reader"
  ])

  role    = each.key
  project = var.project
  member  = "serviceAccount:${google_service_account.management-service-account.email}"
}
