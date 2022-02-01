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
  default = "germanywestcentral"
  #'centralus,eastasia,southeastasia,eastus,eastus2,westus,westus2,northcentralus,southcentralus,westcentralus,northeurope,westeurope,japaneast,japanwest,brazilsouth,australiasoutheast,australiaeast,westindia,southindia,centralindia,canadacentral,canadaeast,uksouth,ukwest,koreacentral,francecentral,southafricanorth,uaenorth,australiacentral,switzerlandnorth,germanywestcentral,norwayeast,jioindiawest,westus3,swedencentral,australiacentral2'.
}

variable "azure_availability_set" {
  type = string
  default = "docker-machine"
}