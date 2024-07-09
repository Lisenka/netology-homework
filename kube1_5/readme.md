### Задание 1. Создать Deployment приложений backend и frontend

1. Создать Deployment приложения _frontend_ из образа nginx с количеством реплик 3 шт.
2. Создать Deployment приложения _backend_ из образа multitool. 
3. Добавить Service, которые обеспечат доступ к обоим приложениям внутри кластера. 
4. Продемонстрировать, что приложения видят друг друга с помощью Service.
5. Предоставить манифесты Deployment и Service в решении, а также скриншоты или вывод команды п.4.

### Ответ:

1. [deployment.yaml](/kube1_5/deployment.yaml)
2. [multitool.yaml](/kube1_5/multitool.yaml)
3. [service.yaml](/kube1_5/service.yaml)
4. ![Task1](/kube1_5/task1_1.jpg "Задание 1")
![Task1](/kube1_5/task1_2.jpg "Задание 1")
![Task1](/kube1_5/task1_3.jpg "Задание 1")
![Task1](/kube1_5/task1_4.jpg "Задание 1")
![Task1](/kube1_5/task1_5.jpg "Задание 1")
![Task1](/kube1_5/task1_6.jpg "Задание 1")

------

### Задание 2. Создать Ingress и обеспечить доступ к приложениям снаружи кластера

1. Включить Ingress-controller в MicroK8S.
2. Создать Ingress, обеспечивающий доступ снаружи по IP-адресу кластера MicroK8S так, чтобы при запросе только по адресу открывался _frontend_ а при добавлении /api - _backend_.
3. Продемонстрировать доступ с помощью браузера или `curl` с локального компьютера.
4. Предоставить манифесты и скриншоты или вывод команды п.2.

### Ответ:

1. ![Task2](/kube1_5/task2_1.jpg "Задание 2")
2. ![ingress.yaml](/kube1_5/ingress.yaml)
3. ![Task2](/kube1_5/task2_2.jpg "Задание 2")