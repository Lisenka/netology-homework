
### Задание 1. Подготовить Helm-чарт для приложения

1. Необходимо упаковать приложение в чарт для деплоя в разные окружения. 
2. Каждый компонент приложения деплоится отдельным deployment’ом или statefulset’ом.
3. В переменных чарта измените образ приложения для изменения версии.

### Ответ:

1. Установим helm:

![Task1](/kube1_10/task1_1.jpg "Задание 1")

2. Создадим чарт:

![Task1](/kube1_10/task1_2.jpg "Задание 1")

------
### Задание 2. Запустить две версии в разных неймспейсах

1. Подготовив чарт, необходимо его проверить. Запуститe несколько копий приложения.
2. Одну версию в namespace=app1, вторую версию в том же неймспейсе, третью версию в namespace=app2.
3. Продемонстрируйте результат.

### Ответ:

1. Запускаем две копии приложения в неймспейсе app1:

![Task2](/kube1_10/task2_1.jpg "Задание 2")

![Task2](/kube1_10/task2_2.jpg "Задание 2")

![Task2](/kube1_10/task2_3.jpg "Задание 2")

2. Запускаем одну копию в неймспейсе app2:

![Task2](/kube1_10/task2_4.jpg "Задание 2")

![Task2](/kube1_10/task2_5.jpg "Задание 2")