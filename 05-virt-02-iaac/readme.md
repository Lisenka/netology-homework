### Задача 1
Опишите основные преимущества применения на практике IaaC-паттернов.
Какой из принципов IaaC является основополагающим?

### Ответ:

Преимуществами IaaC являются ускорение производства и вывода продукта на рынок, стабильность среды, устранение дрейфа конфигураций, более быстрая и эффективная разработка
Основной принцип IaaC - идемпотентность - свойство объекта или операции, при повторном выполнении которой результат получается идентичным предыдущему и всем последующим.

### Задача 2
Чем Ansible выгодно отличается от других систем управление конфигурациями?
Какой, на ваш взгляд, метод работы систем конфигурации более надёжный — push или pull?

### Ответ:

Ansible — это инструмент управления конфигурацией, то есть он предназначен для установки и управления программным обеспечением и состояниями на существующем сервере, и он поддерживает изменяемую инфраструктуру и процедурный язык, являясь при этом безагентным и безмастерным. Среди этих особенностей Ansible две наиболее заметные: (1) безагентность и (2) безмастерность. Например, вы можете просто использовать SSH-ключи для подключения к каждому серверу, который хотите настроить — этот процесс намного упрощает управление инфраструктурой.
Мой выбор будет зависеть от конкретной системы и её задач. В целом, оба метода могут быть надёжными в зависимости от правильной настройки и обслуживания. Однако, pull-метод может быть более предпочтительным в больших системах, где нужно обеспечить единообразие конфигурации и мониторинг изменений. Но push-метод также может быть эффективным, особенно в небольших системах с небольшим объёмом изменений.

### Задача 3
Установите на личный linux-компьютер(или учебную ВМ с linux):

VirtualBox,
Vagrant, рекомендуем версию 2.3.4(в более старших версиях могут возникать проблемы интеграции с ansible)
Terraform версии 1.5.Х (1.6.х может вызывать проблемы с яндекс-облаком),
Ansible.
Приложите вывод команд установленных версий каждой из программ, оформленный в Markdown.

### Ответ:

#### Задача 4
Воспроизведите практическую часть лекции самостоятельно.

Создайте виртуальную машину.
Зайдите внутрь ВМ, убедитесь, что Docker установлен с помощью команды
docker ps,
Vagrantfile из лекции и код ansible находятся в папке.

Примечание. Если Vagrant выдаёт ошибку:

URL: ["https://vagrantcloud.com/bento/ubuntu-20.04"]     
Error: The requested URL returned error: 404:
выполните следующие действия:

Скачайте с сайта файл-образ "bento/ubuntu-20.04".
Добавьте его в список образов Vagrant: "vagrant box add bento/ubuntu-20.04 <путь к файлу>".
Важно!: Если ваша хостовая рабочая станция - это windows ОС, то у вас могут возникнуть проблемы со вложенной виртуализацией. способы решения . Если вы устанавливали hyper-v или docker desktop то все равно может возникать ошибка: Stderr: VBoxManage: error: AMD-V VT-X is not available (VERR_SVM_NO_SVM) . Попробуйте в этом случае выполнить в windows от администратора команду: "bcdedit /set hypervisorlaunchtype off" и перезагрузиться

Приложите скриншоты в качестве решения на эту задачу. Допускается неполное выполнение данного задания если не сможете совладать с Windows.

### Ответ:
