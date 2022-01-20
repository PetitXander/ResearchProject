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
  #TODO
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
  engine_install_url = "https://releases.rancher.com/install-docker/20.10.sh"
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
    open_port = ["6443/tcp","2379/tcp","2380/tcp","8472/udp","4789/udp","9796/tcp","10256/tcp","10250/tcp","10251/tcp","10252/tcp","80/tcp","30001/tcp"]
    ssh_user = "docker-user"
    storage_type = "Standard_LRS"
    managed_disks = false
    disk_size = "30"
    #TODO
  }
}

# Create a new rancher2 cluster template
resource "rancher2_cluster_template" "cluster_template" {
  name = "cluster_template"
  template_revisions {
    name = "V1"
    cluster_config {
      rke_config {
        kubernetes_version = "v1.21.8-rancher1-1"
        ignore_docker_version = false
        network {
          plugin = "canal"
        }
      }
    }
    default = true
  }
  description = "cluster template"
}

resource "rancher2_cluster" "cluster" {
  name = "cluster"
  cluster_template_id = rancher2_cluster_template.cluster_template.id
  cluster_template_revision_id = rancher2_cluster_template.cluster_template.template_revisions.0.id
}

resource "rancher2_node_pool" "node_pool" {
  cluster_id       = rancher2_cluster.cluster.id
  hostname_prefix  = "terraform"
  name             = "nodepool"
  node_template_id = rancher2_node_template.azure_template.id
  quantity = 1
  control_plane = true
  etcd = true
  worker = true
  #TODO
}

