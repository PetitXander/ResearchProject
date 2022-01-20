terraform {
  required_providers {
    rancher2 = {
      source = "rancher/rancher2"
    }
  }
}

provider "rancher2" {
  api_url    = "https://52.143.156.208"
  access_key = var.rancher_access_key
  secret_key = var.rancher_secret_key
  insecure = true
}

resource "rancher2_cloud_credential" "cloud_creds_azure" {
  name = "cloud_creds"
  azure_credential_config {
    client_id       = var.azure_id
    client_secret   = var.azure_secret
    subscription_id = var.azure_sub
  }
}

resource "rancher2_node_template" "azure_template" {
  name = "Azure_template"
  cloud_credential_id = rancher2_cloud_credential.cloud_creds_azure.id
  azure_config {
    location = var.azure_location
    availability_set = var.azure_availability_set
    fault_domain_count = "3"
    update_domain_count = "5"
    resource_group = "docker-machine"
    subnet = "docker-machine"
    subnet_prefix = "192.168.0.0/16"
    vnet = "docker-machine-vnet"
    static_public_ip = false
    nsg = "docker-machine-nsg"
    image = "canonical:UbuntuServer:18.04-LTS:latest"
    size = "Standard_B2ms"
    docker_port = "2376"
    #open_port = [6443/tcp,2379/tcp,2380/tcp,8472/udp,4789/udp,9796/tcp,10256/tcp,10250/tcp,10251/tcp,10252/tcp]
    ssh_user = "docker-user"
    storage_type = "Standard_LRS"
    managed_disks = false
    disk_size = "30"
  }
}