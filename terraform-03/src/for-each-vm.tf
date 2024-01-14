data "yandex_compute_image" "ubuntu2" {
  family = "ubuntu-2004-lts"
}
resource "yandex_compute_instance" "web2" {
  depends_on = [yandex_compute_instance.web]  
  for_each = {
    main = var.each_vm[0]
    replica = var.each_vm[1]
  }    
  name = "${each.value.vm_name}"
  platform_id = "standard-v1"

  resources {
    cores         = "${each.value.cpu}"
    memory        = "${each.value.ram}"
    core_fraction = 5
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size = "${each.value.disk}"
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = local.ssh-keys
  }
}
