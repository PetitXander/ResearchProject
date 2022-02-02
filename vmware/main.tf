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

resource "rancher2_cloud_credential" "creds_vsphere" {
  name = "vsphere_creds"
  vsphere_credential_config {
    password = var.vsphere_pwd
    username = var.vsphere_user
    vcenter  = var.vsphere_ip
  }
}

resource "rancher2_node_template" "vsphere_template" {
  name = "Vsphere_template"
  cloud_credential_id = rancher2_cloud_credential.creds_vsphere.id
  engine_install_url = "https://releases.rancher.com/install-docker/20.10.sh"
  vsphere_config {
    datacenter = var.datacenter
    datastore = var.datastore
    cpu_count = var.cpu_count
    memory_size = var.memory_size
    disk_size = var.disk_size
    network = ["VM Network"]
    cfgparam = ["disk.enableUUID=TRUE"]
    creation_type = "template"
    clone_from = var.clone_from

  }
}

# Create a new rancher2 cluster template
resource "rancher2_cluster_template" "cluster_template" {
  name = var.cluster_temp_name
  template_revisions {
    name = var.cluster_temp_revision
    cluster_config {
      rke_config {
        kubernetes_version = var.kubernetes_version
        ignore_docker_version = var.ignore_docker_version
        network {
          plugin = "canal"
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
  hostname_prefix  = var.hostname_prefix
  name             = var.nodepool_name
  node_template_id = rancher2_node_template.vsphere_template.id
  quantity = var.nodepool_quantity
  control_plane = var.control_plane
  etcd = var.etcd
  worker = var.worker

}

