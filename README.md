# terraform-google-vaulthelm

Module to deploy the Vault Helm chart on Google Kubernetes Engine.
By default, it creates a publicly available, HA Vault that
uses a GCS storage backend and autounseals with GCP KMS.