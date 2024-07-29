
### Задание 1. Создать Deployment приложения и решить возникшую проблему с помощью ConfigMap. Добавить веб-страницу

1. Создать Deployment приложения, состоящего из контейнеров nginx и multitool.
2. Решить возникшую проблему с помощью ConfigMap.
3. Продемонстрировать, что pod стартовал и оба конейнера работают.
4. Сделать простую веб-страницу и подключить её к Nginx с помощью ConfigMap. Подключить Service и показать вывод curl или в браузере.
5. Предоставить манифесты, а также скриншоты или вывод необходимых команд.

------

### Ответ:

1. [deployment.yaml](/kube1_8/deployment.yaml)

2. [configmap.yaml](/kube1_8/configmap.yaml)

3. ![Task1](/kube1_8/task1_1.jpg "Задание 1")

4. [service.yaml](/kube1_8/service.yaml)

5.![Task1](/kube1_8/task1_2.jpg "Задание 1")


### Задание 2. Создать приложение с вашей веб-страницей, доступной по HTTPS 

1. Создать Deployment приложения, состоящего из Nginx.
2. Создать собственную веб-страницу и подключить её как ConfigMap к приложению.
3. Выпустить самоподписной сертификат SSL. Создать Secret для использования сертификата.
4. Создать Ingress и необходимый Service, подключить к нему SSL в вид. Продемонстировать доступ к приложению по HTTPS. 
4. Предоставить манифесты, а также скриншоты или вывод необходимых команд.

### Ответ:

1. [deployment.yaml](/kube1_8/deployment-nginx.yaml)

2. [configmap-nginx.yaml](/kube1_8/configmap-nginx.yaml)

3. ![Task2](/kube1_8/task2_1.jpg "Задание 2")

4. ![Task2](/kube1_8/task2_2.jpg "Задание 2")

5. [service-nginx.yaml](/kube1_8/service-nginx.yaml)

6. [ingress-nginx.yaml](/kube1_8/ingress-nginx.yaml)

7. ![Task2](/kube1_8/task2_3.jpg "Задание 2")