resource "local_file" "ansible_inventory" {
  filename = "./inventory.yaml"
  content = templatefile("ansible.tpl", {
    webservers = yandex_compute_instance.web,
    databases = yandex_compute_instance.web2,
    storage = [yandex_compute_instance.web3]
  })
}

resource "null_resource" "web_hosts_provision" {
depends_on = [yandex_compute_instance.web, yandex_compute_instance.web2, yandex_compute_instance.web3]

  provisioner "local-exec" {
	command = "sleep 90"
  }

#Запуск ansible-playbook
  provisioner "local-exec" {
    command  = "export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i ${abspath(path.module)}/inventory.yaml ${abspath(path.module)}/test.yaml"
    on_failure = continue #Продолжить выполнение terraform pipeline в случае ошибок
    environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }
    #срабатывание триггера при изменении переменных
  }
    triggers = {
      always_run         = "${timestamp()}" #всегда т.к. дата и время постоянно изменяются
      playbook_src_hash  = file("${abspath(path.module)}/test.yaml") # при изменении содержимого playbook файла
      ssh_public_key     = local.ssh-keys # при изменении переменной
    }
}

