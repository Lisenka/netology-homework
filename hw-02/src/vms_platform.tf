###compute_instance vars

#variable "vm_db_platform_name" {
#  type        = string
#  default     = "netology-develop-platform-db"
#  description = "Platform name"
#}

variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "Platform id"
}

#variable "vm_db_resources" {
#  type        = map(number)
#  default     = {
#    cores         = 2,
#    memory        = 2,
#   core_fraction = 20
#}
#  description = "Instance resources"
#}

