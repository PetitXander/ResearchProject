variable "rancher_access_key" {
  type = string
  sensitive = true
}

variable "rancher_secret_key" {
  type = string
  sensitive = true
}

variable "rancher_url" {
  type = string
  sensitive = true
}

variable "vsphere_user" {
  type = string
  sensitive = true
}

variable "vsphere_pwd" {
  type = string
  sensitive = true
}

variable "vsphere_ip" {
  type = string
  sensitive = true
}

## NODE TEMPLATE

## MUST CHANGE
variable "datacenter" {
  type = string
  default = "StudentDatacenter"
}

variable "datastore" {
  type = string
  default = "petit-xander"
}

## MUST CHANGE ^^

variable "cpu_count" {
  type = string
  default = "2"
}

variable "memory_size" {
  type = string
  default = "2048"
}

variable "disk_size" {
  type = string
  default = "20000"
}

variable "clone_from" {
  type = string
  default = "ubuntu-focal-20.04-cloudimg"
}

## CLUSTER TEMPLATE
variable "cluster_temp_name" {
  type = string
  default = "cluster_template"
}

variable "cluster_temp_revision" {
  type = string
  default = "V1"
}

variable "cluster_temp_description" {
  type = string
  default = "cluster template"
}

variable "kubernetes_version" {
  type = string
  default = "v1.21.8-rancher1-1"
}

variable "ignore_docker_version" {
  type = string
  default = "false"
}

## CLUSTER

variable "cluster_name" {
  type = string
  default = "cluster"
}

## NODE POOL
variable "hostname_prefix" {
  type = string
  default = "terraform"
}

variable "nodepool_name" {
  type = string
  default = "nodepool"
}

variable "nodepool_quantity" {
  type = string
  default = "1"
}
variable "control_plane" {
  type = string
  default = "true"
}

variable "etcd" {
  type = string
  default = "true"
}

variable "worker" {
  type = string
  default = "true"
}



