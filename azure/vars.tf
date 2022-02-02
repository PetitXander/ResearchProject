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

variable "azure_id" {
  type = string
  sensitive = true
}

variable "azure_secret" {
  type = string
  sensitive = true
}

variable "azure_sub" {
  type = string
  sensitive = true
}

## NODE TEMPLATE

variable "node_temp_name" {
  type = string
  default = "Azure_template"
}

variable "node_fault_domain" {
  type = string
  default = "3"
}

variable "node_update_domain_count" {
  type = string
  default = "5"
}

variable "node_resourcegroup_name" {
  type = string
  default = "docker_machine"
}

variable "node_subnet_name" {
  type = string
  default = "docker_machine"
}

variable "node_subnet_prefix" {
  type = string
  default = "192.168.0.0/16"
}

variable "node_vnet_name" {
  type = string
  default = "docker-machine-vnet"
}

variable "node_static_public_ip" {
  type = string
  default = "false"
}

variable "node_nsg_name" {
  type = string
  default = "docker-machine-nsg"
}
variable "node_image" {
  type = string
  default = "canonical:UbuntuServer:18.04-LTS:latest"
}

variable "node_size" {
  type = string
  default = "Standard_B2ms"
}

variable "node_docker_port" {
  type = string
  default = "2376"
}

variable "node_ssh_user" {
  type = string
  default = "docker_user"
}

variable "node_storage_type" {
  type = string
  default = "Standard_LRS"
}

variable "node_managed_disk" {
  type = string
  default = "false"
}

variable "node_disk_size" {
  type = string
  default = "30"
}

variable "azure_location" {
  type = string
  default = "germanywestcentral"
  #'centralus,eastasia,southeastasia,eastus,eastus2,westus,westus2,northcentralus,southcentralus,westcentralus,northeurope,westeurope,japaneast,japanwest,brazilsouth,australiasoutheast,australiaeast,westindia,southindia,centralindia,canadacentral,canadaeast,uksouth,ukwest,koreacentral,francecentral,southafricanorth,uaenorth,australiacentral,switzerlandnorth,germanywestcentral,norwayeast,jioindiawest,westus3,swedencentral,australiacentral2'.
}

variable "azure_availability_set_name" {
  type = string
  default = "docker-machine"
}

## CLUSTER TEMPLATE
variable "cluster_temp_name" {
  type = string
  default = "azure_cluster_template"
}

variable "cluster_temp_rev" {
  type = string
  default = "V1"
}

variable "cluster_temp_kubernetes_version" {
  type = string
  default = "v1.21.8-rancher1-1"
}

variable "cluster_temp_ignore_docker_version" {
  type = string
  default = "false"
}

variable "cluster_temp_network_plugin" {
  type = string
  default = "canal"
}

variable "cluster_temp_description" {
  type = string
  default = "azure cluster template"
}

## CLUSTER

variable "cluster_name" {
  type = string
  default = "cluster"
}

## NODE POOL

variable "node_pool_hostname_prefix" {
  type = string
  default = "terraform"
}

variable "node_pool_name" {
  type = string
  default = "nodepool"
}

variable "node_pool_quantity" {
  type = string
  default = "1"
}

variable "node_pool_control_plane" {
  type = string
  default = "true"
}

variable "node_pool_etcd" {
  type = string
  default = "true"
}

variable "node_pool_worker" {
  type = string
  default = "true"
}