provider "rancher2" {
  api_url    = "https://52.143.156.208"
  access_key = var.rancher_access_key
  secret_key = var.rancher_secret_key
}

resource "rancher2_cloud_credential" "cloud_creds" {
  name = "cloud_creds"
  azure_credential_config {
    client_id       = var.azure_id
    client_secret   = var.azure_secret
    subscription_id = var.azure_sub
  }
}