terraform {
  required_providers {
    rancher2 = {
      source = "rancher/rancher2"
    }
  }
}

provider "rancher2" {
  api_url    = "https://192.168.50.104"
  access_key = var.rancher_access_key
  secret_key = var.rancher_secret_key
  insecure = true
  #TODO
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
    datacenter = "StudentDatacenter"
    pool = "host/StudentCluster/Resources"
    datastore = "petit-xander"
    folder = "/StudentDatacenter/vm"
    cpu_count = "2"
    memory_size = "2048"
    disk_size = "20000"
    creation_type = "template"
    #todo
    network = ["VM Network"]
    custom_attributes = ["disk.enableUUID=TRUE"]

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
  node_template_id = rancher2_node_template.vsphere_template.id
  quantity = 1
  control_plane = true
  etcd = true
  worker = true
  #TODO
}

