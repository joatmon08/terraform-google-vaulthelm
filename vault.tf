resource "kubernetes_namespace" "vault" {
  metadata {
    annotations = {
      name = var.namespace
    }

    name = var.namespace
  }
}

resource "kubernetes_secret" "vault_google_credentials" {
  metadata {
    name      = "gcs-bucket-credentials"
    namespace = var.namespace
  }

  data = {
    json = base64decode(google_service_account_key.vault.private_key)
  }
  
  depends_on = [kubernetes_namespace.vault]
}

resource "helm_release" "vault" {
  name      = "vault"
  chart     = "${path.module}/vault-helm"
  namespace = var.namespace
  wait      = false
  values = [
    templatefile("${path.module}/values.yml", {
      bucket    = google_storage_bucket.vault.name
      project   = var.project
      region    = var.region
      keyring   = google_kms_key_ring.vault.name
      key       = google_kms_crypto_key.vault-init.name
      }
    )
  ]
  depends_on = [google_storage_bucket.vault, google_kms_crypto_key.vault-init, kubernetes_secret.vault_google_credentials]
}