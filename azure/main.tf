terraform {
  required_providers {
    rancher2 = {
      source = "rancher/rancher2"
    }
  }
}

provider "rancher2" {
  api_url    = var.rancher_url
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
  name = var.node_temp_name
  cloud_credential_id = rancher2_cloud_credential.cloud_creds_azure.id
  engine_install_url = "https://releases.rancher.com/install-docker/20.10.sh"
  azure_config {
    location = var.azure_location
    availability_set = var.azure_availability_set_name
    fault_domain_count = var.node_fault_domain
    update_domain_count = var.node_update_domain_count
    resource_group = var.node_resourcegroup_name
    subnet = var.node_subnet_name
    subnet_prefix = var.node_subnet_prefix
    vnet = var.node_vnet_name
    static_public_ip = var.node_static_public_ip
    nsg = var.node_nsg_name
    image = var.node_image
    size = var.node_size
    docker_port = var.node_docker_port
    open_port = ["6443/tcp","2379/tcp","2380/tcp","8472/udp","4789/udp","9796/tcp","10256/tcp","10250/tcp","10251/tcp","10252/tcp","80/tcp","30001/tcp"]
    ssh_user = var.node_ssh_user
    storage_type = var.node_storage_type
    managed_disks = var.node_managed_disk
    disk_size = var.node_disk_size

  }
}

# Create a new rancher2 cluster template
resource "rancher2_cluster_template" "cluster_template" {
  name = var.cluster_temp_name
  template_revisions {
    name = var.cluster_temp_rev
    cluster_config {
      rke_config {
        kubernetes_version = var.cluster_temp_kubernetes_version
        ignore_docker_version = var.cluster_temp_ignore_docker_version
        network {
          plugin = var.cluster_temp_network_plugin
        }
      }
    }
    default = true
  }
  description = var.cluster_temp_description
}

resource "rancher2_cluster" "cluster" {
  name = var.cluster_name
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

}

