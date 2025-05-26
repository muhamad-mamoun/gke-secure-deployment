terraform {
  backend "gcs" {
    bucket = "terraform-state-files-host"
    prefix = "Terraform"
  }
}
