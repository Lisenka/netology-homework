### Задание 1. Yandex Cloud 

**Что нужно сделать**

1. Создать пустую VPC. Выбрать зону.
2. Публичная подсеть.

 - Создать в VPC subnet с названием public, сетью 192.168.10.0/24.
 - Создать в этой подсети NAT-инстанс, присвоив ему адрес 192.168.10.254. В качестве image_id использовать fd80mrhj8fl2oe87o4e1.
 - Создать в этой публичной подсети виртуалку с публичным IP, подключиться к ней и убедиться, что есть доступ к интернету.
3. Приватная подсеть.
 - Создать в VPC subnet с названием private, сетью 192.168.20.0/24.
 - Создать route table. Добавить статический маршрут, направляющий весь исходящий трафик private сети в NAT-инстанс.
 - Создать в этой приватной подсети виртуалку с внутренним IP, подключиться к ней через виртуалку, созданную ранее, и убедиться, что есть доступ к интернету.

Resource Terraform для Yandex Cloud:

- [VPC subnet](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet).
- [Route table](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_route_table).
- [Compute Instance](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_instance).

### Ответ:

1. Создаем пустую сеть:

```
resource "yandex_vpc_network" "network" {
  name = var.vpc_name
}
```

```
variable "vpc_name" {
  type        = string
  default     = "network"
  description = "VPC network"
}
```

2. Создаем публичную подсеть, NAT и виртуалку:

см. [network.tf](/cloud_02/network-terraform/network.tf), [variables.tf](/cloud_02/network-terraform/variables.tf), [public.tf](/cloud_02/network-terraform/public.tf)


Подключаемся к публичной ВМ:

![Task1](/cloud_02/task1_4.jpg "Задание 1")

Проверяем, что Интернет есть:

![Task1](/cloud_02/task1_2.jpg "Задание 1")

3. Создаем приватную подсеть и виртуалку с внутренним IP:

см. [network.tf](/cloud_02/network-terraform/network.tf), [variables.tf](/cloud_02/network-terraform/variables.tf), [private.tf](/cloud_02/network-terraform/private.tf)

Копируем ssh-ключ на публичную ВМ для подключения к приватной:

![Task1](/cloud_02/task1_3.jpg "Задание 1")

Подключаеемся сначала к публичной:

![Task1](/cloud_02/task1_4.jpg "Задание 1")

Потом из публичной к приватной по внутреннему IP:

![Task1](/cloud_02/task1_5.jpg "Задание 1")

Проверяем, что Интернет есть:

![Task1](/cloud_02/task1_6.jpg "Задание 1")

Остановим NAT и убедимся, что Интернет на приватной машине пропадет:

![Task1](/cloud_02/task1_7.jpg "Задание 1")

![Task1](/cloud_02/task1_8.jpg "Задание 1")

Список инстансов, которые в итоге получились:

![Task1](/cloud_02/task1_1.jpg "Задание 1")



