
### Задание 1 

**Что нужно сделать**

Создать Deployment приложения, состоящего из двух контейнеров и обменивающихся данными.

1. Создать Deployment приложения, состоящего из контейнеров busybox и multitool.
2. Сделать так, чтобы busybox писал каждые пять секунд в некий файл в общей директории.
3. Обеспечить возможность чтения файла контейнером multitool.
4. Продемонстрировать, что multitool может читать файл, который периодоически обновляется.
5. Предоставить манифесты Deployment в решении, а также скриншоты или вывод команды из п. 4.

### Ответ:

1. [deployment.yaml](/kube1_6/deployment.yaml)
![Task1](/kube1_6/task1_1.jpg "Задание 1")
2. Проверим, что файл пишется, доступен из обоих контейнеров и читается из контейнера multitool:

![Task1](/kube1_6/task1_2.jpg "Задание 1")
![Task1](/kube1_6/task1_3.jpg "Задание 1")
![Task1](/kube1_6/task1_4.jpg "Задание 1")

------

### Задание 2

**Что нужно сделать**

Создать DaemonSet приложения, которое может прочитать логи ноды.

1. Создать DaemonSet приложения, состоящего из multitool.
2. Обеспечить возможность чтения файла `/var/log/syslog` кластера MicroK8S.
3. Продемонстрировать возможность чтения файла изнутри пода.
4. Предоставить манифесты Deployment, а также скриншоты или вывод команды из п. 2.

### Ответ:

1. 1. [daemonset.yaml](/kube1_6/daemonset.yaml)
![Task2](/kube1_6/task2_1.jpg "Задание 2")

2. ![Task2](/kube1_6/task2_2.jpg "Задание 2")