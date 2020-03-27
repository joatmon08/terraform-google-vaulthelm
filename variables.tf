variable "project" {
  type        = string
  description = "GCP Project"
}

variable "region" {
  type        = string
  description = "GCP Region"
}

variable "kubernetes_cluster" {
  type        = string
  description = "Name of GKE cluster"
}

variable "kubernetes_cluster_location" {
  type        = string
  description = "Location of GKE cluster"
}

variable "storage_bucket_roles" {
  type = list(string)
  default = [
    "roles/storage.legacyBucketReader",
    "roles/storage.objectAdmin",
  ]
  description = "List of storage bucket roles."
}

variable "kms_crypto_key" {
  type        = string
  default     = "vault-init"
  description = "String value to use for the name of the KMS crypto key."
}

variable "kms_key_ring_prefix" {
  type        = string
  default     = "vault-"
  description = "String value to prefix the generated key ring with."
}

variable "namespace" {
  type        = string
  default     = "secret"
  description = "Namespace to deploy Vault"
}