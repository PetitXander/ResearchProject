variable "rancher_access_key" {
  type = string
  sensitive = true
}

variable "rancher_secret_key" {
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

variable "azure_location" {
  type = string
  default = "germanynorth"
  #default = "germanywest"
}

variable "azure_availability_set" {
  type = string
  default = "docker-machine"
}