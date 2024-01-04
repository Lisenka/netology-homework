output "vm_external_ip1" {
  value = "${ yandex_compute_instance.platform.name } = ${ yandex_compute_instance.platform.network_interface[0].nat_ip_address }"
}
                                                                                                                                                                    
output "vm_external_ip2" {
  value = "${ yandex_compute_instance.platform2.name } = ${ yandex_compute_instance.platform2.network_interface[0].nat_ip_address }"
}
