# Дипломный практикум в Yandex.Cloud
  * [Цели:](#цели)
  * [Этапы выполнения:](#этапы-выполнения)
     * [Создание облачной инфраструктуры](#создание-облачной-инфраструктуры)
     * [Создание Kubernetes кластера](#создание-kubernetes-кластера)
     * [Создание тестового приложения](#создание-тестового-приложения)
     * [Подготовка cистемы мониторинга и деплой приложения](#подготовка-cистемы-мониторинга-и-деплой-приложения)
     * [Установка и настройка CI/CD](#установка-и-настройка-cicd)
  * [Что необходимо для сдачи задания?](#что-необходимо-для-сдачи-задания)
  * [Как правильно задавать вопросы дипломному руководителю?](#как-правильно-задавать-вопросы-дипломному-руководителю)

**Перед началом работы над дипломным заданием изучите [Инструкция по экономии облачных ресурсов](https://github.com/netology-code/devops-materials/blob/master/cloudwork.MD).**

---
## Цели:

1. Подготовить облачную инфраструктуру на базе облачного провайдера Яндекс.Облако.
2. Запустить и сконфигурировать Kubernetes кластер.
3. Установить и настроить систему мониторинга.
4. Настроить и автоматизировать сборку тестового приложения с использованием Docker-контейнеров.
5. Настроить CI для автоматической сборки и тестирования.
6. Настроить CD для автоматического развёртывания приложения.

---
## Этапы выполнения:


### Создание облачной инфраструктуры

Для начала необходимо подготовить облачную инфраструктуру в ЯО при помощи [Terraform](https://www.terraform.io/).

Особенности выполнения:

- Бюджет купона ограничен, что следует иметь в виду при проектировании инфраструктуры и использовании ресурсов;
Для облачного k8s используйте региональный мастер(неотказоустойчивый). Для self-hosted k8s минимизируйте ресурсы ВМ и долю ЦПУ. В обоих вариантах используйте прерываемые ВМ для worker nodes.

Предварительная подготовка к установке и запуску Kubernetes кластера.

1. Создайте сервисный аккаунт, который будет в дальнейшем использоваться Terraform для работы с инфраструктурой с необходимыми и достаточными правами. Не стоит использовать права суперпользователя
2. Подготовьте [backend](https://www.terraform.io/docs/language/settings/backends/index.html) для Terraform:  
   а. Рекомендуемый вариант: S3 bucket в созданном ЯО аккаунте(создание бакета через TF)
   б. Альтернативный вариант:  [Terraform Cloud](https://app.terraform.io/)
3. Создайте конфигурацию Terrafrom, используя созданный бакет ранее как бекенд для хранения стейт файла. Конфигурации Terraform для создания сервисного аккаунта и бакета и основной инфраструктуры следует сохранить в разных папках.
4. Создайте VPC с подсетями в разных зонах доступности.
5. Убедитесь, что теперь вы можете выполнить команды `terraform destroy` и `terraform apply` без дополнительных ручных действий.
6. В случае использования [Terraform Cloud](https://app.terraform.io/) в качестве [backend](https://www.terraform.io/docs/language/settings/backends/index.html) убедитесь, что применение изменений успешно проходит, используя web-интерфейс Terraform cloud.

Ожидаемые результаты:

1. Terraform сконфигурирован и создание инфраструктуры посредством Terraform возможно без дополнительных ручных действий, стейт основной конфигурации сохраняется в бакете или Terraform Cloud
2. Полученная конфигурация инфраструктуры является предварительной, поэтому в ходе дальнейшего выполнения задания возможны изменения.

### Ответ:

1. Создаю сервисный аккаунт для Terraform и роль:

```
// сервисный аккаунт
resource "yandex_iam_service_account" "service" {
  folder_id = var.folder_id
  name      = "diplom-sa"
}

// роли для сервисного аккаунта
resource "yandex_resourcemanager_folder_iam_member" "editor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.service.id}"
}
```

2. Для бэкенда буду использовать S3-bucket:

```
// статический ключ
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.service.id
}

resource "yandex_storage_bucket" "bucket-yakunichkina-netology" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket = "bucket-yakunichkina"
  acl    = "private"
  force_destroy = true
}

resource "local_file" "backend" {
  content  = <<EOT
endpoint = "storage.yandexcloud.net"
bucket = "${yandex_storage_bucket.bucket-yakunichkina-netology.bucket}"
region = "ru-central1"
key = "terraform/terraform.tfstate"
access_key = "${yandex_iam_service_account_static_access_key.sa-static-key.access_key}"
secret_key = "${yandex_iam_service_account_static_access_key.sa-static-key.secret_key}"
skip_region_validation = true
skip_credentials_validation = true
EOT
  filename = "../backend.key"
}
```

3. Поместим в бакет стейт-файл TF.
```
// поместим стейт файл в баскет
resource "yandex_storage_object" "state-file" {
    access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
    secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
    bucket = yandex_storage_bucket.bucket-yakunichkina-netology.bucket
    key = "terraform.tfstate"
    source = "../terraform.tfstate"
    acl    = "private"
    depends_on = [yandex_storage_bucket.bucket-yakunichkina-netology]
}
```
4. VPC с разными зонами доступности описаны в файле [network.tf](/diplom/terraform/network.tf)
5. Команды `terraform destroy` и `terraform apply` выполняются без дополнительных ручных действий:
![Task1](/diplom/task1_1.jpg "Задание 1")


![Task1](/diplom/task1_2.jpg "Задание 1")


![Task1](/diplom/task1_3.jpg "Задание 1")


![Task1](/diplom/task1_4.jpg "Задание 1")


![Task1](/diplom/task1_6.jpg "Задание 1")


---
### Создание Kubernetes кластера

На этом этапе необходимо создать [Kubernetes](https://kubernetes.io/ru/docs/concepts/overview/what-is-kubernetes/) кластер на базе предварительно созданной инфраструктуры.   Требуется обеспечить доступ к ресурсам из Интернета.

Это можно сделать двумя способами:

1. Рекомендуемый вариант: самостоятельная установка Kubernetes кластера.  
   а. При помощи Terraform подготовить как минимум 3 виртуальных машины Compute Cloud для создания Kubernetes-кластера. Тип виртуальной машины следует выбрать самостоятельно с учётом требовании к производительности и стоимости. Если в дальнейшем поймете, что необходимо сменить тип инстанса, используйте Terraform для внесения изменений.  
   б. Подготовить [ansible](https://www.ansible.com/) конфигурации, можно воспользоваться, например [Kubespray](https://kubernetes.io/docs/setup/production-environment/tools/kubespray/)  
   в. Задеплоить Kubernetes на подготовленные ранее инстансы, в случае нехватки каких-либо ресурсов вы всегда можете создать их при помощи Terraform.
2. Альтернативный вариант: воспользуйтесь сервисом [Yandex Managed Service for Kubernetes](https://cloud.yandex.ru/services/managed-kubernetes)  
  а. С помощью terraform resource для [kubernetes](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/kubernetes_cluster) создать **региональный** мастер kubernetes с размещением нод в разных 3 подсетях      
  б. С помощью terraform resource для [kubernetes node group](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/kubernetes_node_group)
  
Ожидаемый результат:

1. Работоспособный Kubernetes кластер.
2. В файле `~/.kube/config` находятся данные для доступа к кластеру.
3. Команда `kubectl get pods --all-namespaces` отрабатывает без ошибок.

### Ответ:

1. Создание виртуальных машин описано в файле [vm.tf](/diplom/terraform/vm.tf)

![Task2](/diplom/task1_5.jpg "Задание 2")

2. Kubernetes-кластер буду создавать при помощи Kubespray.
Для заполнения файла inventory использую файл [ansible.tf](/diplom/terraform/ansible.tf)
и шаблон [hosts.tftpl](/diplom/terraform/hosts.tftpl)

Применяю команду: `sudo ansible-playbook -i inventory/mycluster/hosts.yaml -u ubuntu --become --become-user=root --private-key=/home/yakunichkina/.ssh/id_ed25519 -e 'ansible_ssh_common_args="-o StrictHostKeyChecking=no"' cluster.yml --flush-cache`

Кластер создался:

![Task2](/diplom/task2_1.jpg "Задание 2")

Вывод команды `kubectl get pods --all-namespaces`:
![Task2](/diplom/task2_3.jpg "Задание 2")

Вывод `kubectl get pods`:
![Task2](/diplom/task2_4.jpg "Задание 2")

Содержимое файла `~/.kube/config`:
![Task2](/diplom/task2_5.jpg "Задание 2")

---
### Создание тестового приложения

Для перехода к следующему этапу необходимо подготовить тестовое приложение, эмулирующее основное приложение разрабатываемое вашей компанией.

Способ подготовки:

1. Рекомендуемый вариант:  
   а. Создайте отдельный git репозиторий с простым nginx конфигом, который будет отдавать статические данные.  
   б. Подготовьте Dockerfile для создания образа приложения.  
2. Альтернативный вариант:  
   а. Используйте любой другой код, главное, чтобы был самостоятельно создан Dockerfile.

Ожидаемый результат:

1. Git репозиторий с тестовым приложением и Dockerfile.
2. Регистри с собранным docker image. В качестве регистри может быть DockerHub или [Yandex Container Registry](https://cloud.yandex.ru/services/container-registry), созданный также с помощью terraform.

### Ответ:

1. Сoздаю отдельный репозиторий: https://github.com/Lisenka/netology_diplom
2. Создаю статичную страничку:
```
<html>
    <head>
        <title>Lisenka</title>
    </head> 
        <body>
            <h1>The best animal in the nature</h1>
            <img src="fox.jpeg"/>
        </body>
</html>
```
2. Помещаю ее и картинку в репозиторий.
3. Создаю Dockerfile:

```
FROM nginx:1.27.0
RUN rm -rf /usr/share/nginx/html/*
COPY . /usr/share/nginx/html/
EXPOSE 80
```
4. Соберу образ приложения:

![Task3](/diplom/task3_1.jpg "Задание 3")

5. Опубликую образ:

![Task3](/diplom/task3_2.jpg "Задание 3")

Ссылка на dockerhub с образом:

https://hub.docker.com/repository/docker/lisenka/netology-diplom/general

---
### Подготовка cистемы мониторинга и деплой приложения

Уже должны быть готовы конфигурации для автоматического создания облачной инфраструктуры и поднятия Kubernetes кластера.  
Теперь необходимо подготовить конфигурационные файлы для настройки нашего Kubernetes кластера.

Цель:
1. Задеплоить в кластер [prometheus](https://prometheus.io/), [grafana](https://grafana.com/), [alertmanager](https://github.com/prometheus/alertmanager), [экспортер](https://github.com/prometheus/node_exporter) основных метрик Kubernetes.
2. Задеплоить тестовое приложение, например, [nginx](https://www.nginx.com/) сервер отдающий статическую страницу.

Способ выполнения:
1. Воспользоваться пакетом [kube-prometheus](https://github.com/prometheus-operator/kube-prometheus), который уже включает в себя [Kubernetes оператор](https://operatorhub.io/) для [grafana](https://grafana.com/), [prometheus](https://prometheus.io/), [alertmanager](https://github.com/prometheus/alertmanager) и [node_exporter](https://github.com/prometheus/node_exporter). Альтернативный вариант - использовать набор helm чартов от [bitnami](https://github.com/bitnami/charts/tree/main/bitnami).

2. Если на первом этапе вы не воспользовались [Terraform Cloud](https://app.terraform.io/), то задеплойте и настройте в кластере [atlantis](https://www.runatlantis.io/) для отслеживания изменений инфраструктуры. Альтернативный вариант 3 задания: вместо Terraform Cloud или atlantis настройте на автоматический запуск и применение конфигурации terraform из вашего git-репозитория в выбранной вами CI-CD системе при любом комите в main ветку. Предоставьте скриншоты работы пайплайна из CI/CD системы.

Ожидаемый результат:
1. Git репозиторий с конфигурационными файлами для настройки Kubernetes.
2. Http доступ на 80 порту к web интерфейсу grafana.
3. Дашборды в grafana отображающие состояние Kubernetes кластера.
4. Http доступ на 80 порту к тестовому приложению.

### Ответ:

1. Установлю helm на главное ноде:

![Task4](/diplom/task4_1.jpg "Задание 4")

2. Добавлю репозиторий "prometheus-community":

![Task4](/diplom/task4_2.jpg "Задание 4")

3. Установлю prometheus-community с настройками, записанными в файл values.yaml:

![Task4](/diplom/task4_3.jpg "Задание 4")

4. Проверю, что grafana доступна извне:

![Task4](/diplom/task4_7.jpg "Задание 4")

5. Подготовлю файл [deployment.yaml](/diplom/app/deployment.yaml) для деплоя моего тестового приложения.
Применю его и проверю результат:

![Task4](/diplom/task4_5.jpg "Задание 4")

6. Подготовлю файл [service.yaml](/diplom/app/service.yaml)

Применю и проверю результат:

![Task4](/diplom/task4_6.jpg "Задание 4")

7. Проверю, что мое приложение доступно извне:

![Task4](/diplom/task4_8.jpg "Задание 4")

---
### Установка и настройка CI/CD

Осталось настроить ci/cd систему для автоматической сборки docker image и деплоя приложения при изменении кода.

Цель:

1. Автоматическая сборка docker образа при коммите в репозиторий с тестовым приложением.
2. Автоматический деплой нового docker образа.

Можно использовать [teamcity](https://www.jetbrains.com/ru-ru/teamcity/), [jenkins](https://www.jenkins.io/), [GitLab CI](https://about.gitlab.com/stages-devops-lifecycle/continuous-integration/) или GitHub Actions.

Ожидаемый результат:

1. Интерфейс ci/cd сервиса доступен по http.
2. При любом коммите в репозиторие с тестовым приложением происходит сборка и отправка в регистр Docker образа.
3. При создании тега (например, v1.0.0) происходит сборка и отправка с соответствующим label в регистри, а также деплой соответствующего Docker образа в кластер Kubernetes.

### Ответ:

1. CI/CD буду настраивать в GitLab.
Создаю проект и переношу туда мой Dockerfile и страничку с картинкой, а также мои файлы кубера:

![Task5](/diplom/task5_1.jpg "Задание 5")

2. Создаю GitLabRunner:

![Task5](/diplom/task5_2.jpg "Задание 5")

3. Далее выполняю действия для регистрации раннера:

![Task5](/diplom/task5_3.jpg "Задание 5")

![Task5](/diplom/task5_4.jpg "Задание 5")

![Task5](/diplom/task5_5.jpg "Задание 5")

![Task5](/diplom/task5_6.jpg "Задание 5")

4. Для написания pipeline мне понадобятся следующие переменные:

![Task5](/diplom/task5_7.jpg "Задание 5")

5. Пишу скрипт `.gitlab-ci.yml`:

```
stages:
  - build
  - deploy

variables:
  IMAGE_TAG_LATEST: latest
  VERSION: ${CI_COMMIT_TAG}
  NAMESPACE: "app"
  DEPLOYMENT_NAME: "app"

build:
  stage: build
  image: docker:latest
  services:
    - name: docker:dind
      alias: dockerhost
      entrypoint: ["dockerd-entrypoint.sh", "--tls=false"]
  variables:
    DOCKER_HOST: tcp://dockerhost:2375/
    DOCKER_DRIVER: overlay2
    DOCKER_TLS_CERTDIR: ""
  script:
    - docker login -u ${DOCKER_USER} -p ${DOCKER_PASSWORD}
    - if [ -z "$VERSION" ]; then VERSION=${IMAGE_TAG_LATEST}; fi
    - docker build -t ${DOCKER_USER}/${IMAGE_NAME}:${VERSION} --platform linux/amd64 -f Dockerfile .
    - docker push ${DOCKER_USER}/${IMAGE_NAME}:${VERSION}

deploy:
  stage: deploy
  image: bitnami/kubectl:latest
  tags:
    - My_runner
  only:
    - main
    - tags
  script:
    - echo "Deploying to Kubernetes..."
    - echo $KUBE_CONFIG | base64 -d > kubeconfig
    - export KUBECONFIG=kubeconfig
    - kubectl apply -f kube/
    - if [ -z "$VERSION" ]; then VERSION=$IMAGE_TAG_LATEST; fi
    - kubectl set image deployment/${DEPLOYMENT_NAME} ${CONTAINER}=${DOCKER_USER}/${IMAGE_NAME}:${VERSION} --namespace=${NAMESPACE}
    - kubectl rollout restart deployment/${DEPLOYMENT_NAME} --namespace=${NAMESPACE}
    - kubectl rollout status deployment/${DEPLOYMENT_NAME} --namespace=${NAMESPACE}
  when: on_success
  ```
У меня будет 2 стадии: сборка и деплой.
На стадии сборки если коммит с тегом, то собирается имидж с указанием версии из тега, если без, то latest.
Вторая стадия деплоя будет запускаться только если первая стадия закончилась успехом.

6. Проверю, изменю страничку и сделаю коммит без тега:

![Task5](/diplom/task5_8.jpg "Задание 5")

В dockerhub имидж собрался с тегом latest:

![Task5](/diplom/task5_9.jpg "Задание 5")

Проверю, изменилась ли моя страничка:

![Task5](/diplom/task5_10.jpg "Задание 5")

Теперь сделаю коммит с тегом:

![Task5](/diplom/task5_11.jpg "Задание 5")

![Task5](/diplom/task5_12.jpg "Задание 5")

Все работает как и задумано.

---

### Итоги:

[Файлы для создания среды в облаке](/diplom/terraform)

[Файлы для бакета](/diplom/terraform/bucket)

[Файл ansible для kubespray](/diplom/terraform/ansible.tf)

[Репозиторий с Dockerfile](https://hub.docker.com/r/lisenka/netology-diplom)

[Репозиторий GitLab](https://gitlab.com/yakunichkina/netology_diplom)

[Тестовое приложение](http://89.169.143.232:30051/)

[Grafana](http://89.169.143.232:30050/login/) потльзователь admin, пароль Netology

