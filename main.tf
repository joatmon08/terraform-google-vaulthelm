provider "google" {
  version = "~> 3.13"
  project = var.project
  region  = var.region
}

provider "random" {
  version = "~> 2.2"
}

data "google_container_cluster" "voter" {
  name     = var.kubernetes_cluster
  location = var.kubernetes_cluster_location
}

data "google_client_config" "default" {}

provider "kubernetes" {
  version          = "~> 1.11"
  load_config_file = false
  host             = data.google_container_cluster.voter.endpoint
  token            = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.voter.master_auth[0].cluster_ca_certificate,
  )
}

provider "helm" {
  version = "~> 1.0"
  kubernetes {
    load_config_file = false
    host             = data.google_container_cluster.voter.endpoint
    token            = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(
      data.google_container_cluster.voter.master_auth[0].cluster_ca_certificate,
    )
  }
}