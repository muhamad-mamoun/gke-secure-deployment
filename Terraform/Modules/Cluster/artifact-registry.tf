resource "google_artifact_registry_repository" "cluster-private-repo" {
  repository_id = "cluster-private-repo"
  location      = var.region
  format        = "DOCKER"

  docker_config {
    immutable_tags = true
  }

  vulnerability_scanning_config {
    enablement_config = "DISABLED"
  }
}
