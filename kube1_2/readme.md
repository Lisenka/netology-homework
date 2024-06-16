### Задание 1. Создать Pod с именем hello-world

1. Создать манифест (yaml-конфигурацию) Pod.
2. Использовать image - gcr.io/kubernetes-e2e-test-images/echoserver:2.2.
3. Подключиться локально к Pod с помощью `kubectl port-forward` и вывести значение (curl или в браузере).

### Ответ:

1. Создадим файл-манифест: [pod.yaml](/kube1_2/pod.yaml)
2. По файлу создаем pod: ![Task1](/kube1_2/task1_1.jpg "Задание 1") 
3. Пробрасываем порты: ![Task1](/kube1_2/task1_2.jpg "Задание 1")
4. Выводим значение через curl: ![Task1](/kube1_2/task1_3.jpg "Задание 1")

### Задание 2. Создать Service и подключить его к Pod

1. Создать Pod с именем netology-web.
2. Использовать image — gcr.io/kubernetes-e2e-test-images/echoserver:2.2.
3. Создать Service с именем netology-svc и подключить к netology-web.
4. Подключиться локально к Service с помощью `kubectl port-forward` и вывести значение (curl или в браузере).

### Ответ:
1. Создадим файл-манифест: [service.yaml](/kube1_2/service.yaml)
2. Создаем pos и service, пробрасываем порт: ![Task2](/kube1_2/task2_1.jpg "Задание 2")
3. Выводим значение: ![Task2](/kube1_2/task2_2.jpg "Задание 2")
4. Результат команды `kubectl get pods` теперь выглядит так: ![Task2](/kube1_2/task2_3.jpg "Задание 2")