###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

###compute_image vars

variable "vm_web_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Image family"
}

###compute_instance vars

variable "vm_web_platform_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "Platform name"
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "Platform id"
}

variable "vm_resources" {
  type        = map(map(number))
  default     = {
    web = {
      cores         = 2,
      memory        = 1,
      core_fraction = 5
    }
    db = {
      cores         = 2,
      memory        = 2,
      core_fraction = 20
    }
}

  description = "Instance resources"
}

###ssh vars

#variable "vms_ssh_root_key" {
#  type        = string
#  default     = "<your_ssh_ed25519_key>"
#  description = "ssh-keygen -t ed25519"
#}

variable "metadata" {
  type = map(string)
  default = {
    serial-port-enable = "1"
    ssh-keys = "ubuntu:your_key"
  }
}
