resource "local_file" "hosts_cfg_kubespray" {

  count = 1
  content  = templatefile("hosts.tftpl", {
    nodes = yandex_compute_instance.cluster-k8s
    
  })
  filename = "../kubespray/inventory/mycluster/hosts.yaml"
}
