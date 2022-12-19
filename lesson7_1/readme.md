### Задание 1. 

Какие преимущества дает подход IAC?

*Приведите ответ в свободной форме.*

### Ответ:

1. Нет необходимости в ручной настройке
2. Скорость
3. Воспроизводимость
4. Масштабируемость

---

### Задание 2 

1. Установите Ansible.
2. Настройте управляемые машины (виртуальные или физические, не менее двух).
3. Создайте файл инвентори. Предлагается использовать файл, размещенный в папке с проектом, а не файл инвентори по умолчанию.
4. Проверьте доступность хостов с помощью модуля ping.


*Приложите скриншоты действий.*
 
 ### Ответ:

 ![Task2](/lesson7_1/task2.jpg "Задание 2")

---

### Задание 3 

Какая разница между параметрами forks и serial? 


*Приведите ответ в свободной форме.*

### Ответ:

Как я понимаю `forks` это кол-во потоков на которых параллельно выполняются задачи над всеми хостами.
А с помощью `serial` задается количество хостов в пачке, над которой выполняются все задачи.

---

### Задание 4 

В этом задании мы будем работать с Ad-hoc коммандами.

1. Установите на управляемых хостах пакет, которого нет(любой).
2. Проверьте статус любого присутствующего на управляемой машине сервиса. 
3. Создайте файл с содержимым "I like Linux" по пути /tmp/netology.txt

*Приложите скриншоты запуска команд.*
 
 ### Ответ:

![Task4](/lesson7_1/task4_1.jpg "Задание 4")
![Task4](/lesson7_1/task4_2.jpg "Задание 4")
![Task4](/lesson7_1/task4_3.jpg "Задание 4")

---

### Задание 5

Напишите 3 playbook'a. При написании рекомендуется использовать текстовый редактор с подсветкой синтаксиса YAML.
Плейбуки должны: 
1. Скачать какой либо архив, создать папку для распаковки и распаковать скаченный архив. Например, можете использовать официальный сайт и зеркало Apache Kafka https://kafka.apache.org/downloads. При этом можно качать как исходный код, так и бинарные файлы (запакованные в архив), в нашем задании не принципиально.
2. Установить пакет tuned из стандартного репозитория вашей ОС. Запустить его как демон (конфигурационный файл systemd появится автоматически при установке). Добавить tuned в автозагрузку.
3. Изменить приветствие системы (motd) при входе на любое другое по вашему желанию. Пожалуйста, в этом задании используйте переменную для задания приветствия. Переменную можно задавать любым удобным вам способом.

*Приложите файлы с плейбуками и вывод выполнения.*

### Ответ:

1. ![Task5](/lesson7_1/task5_1.jpg "Задание 5")

```yaml
---
- hosts: all
  become: true
  tasks:
    - name: "Get archive"
      get_url:
        url: https://downloads.apache.org/kafka/3.3.1/kafka_2.12-3.3.1.tgz
        dest: /tmp/archive.tgz
        mode: '777'

    - name: "Create dir"
      ansible.builtin.file:
        path: /tmp/newdir
        state: directory
        mode: '777'

    - name: "Unzip file"
      ansible.builtin.unarchive:
        src: /tmp/archive.tgz
        dest: /tmp/newdir
        remote_src: yes
...
```
2. ![Task5](/lesson7_1/task5_2.jpg "Задание 5")

```yaml
---
- hosts: "all"
  become: true
  tasks:
  - name: "Install tuned"
    ansible.builtin.apt:
      name: "tuned"
      state: "latest"
      update_cache: true

  - name: "Run tuned"
    service:
      name: tuned
      state: started
      enabled: true
 ...
 ```

3. ![Task5](/lesson7_1/task5_3.jpg "Задание 5")

```yaml
---
- hosts: all
  become: true
  tasks:
  - name: "Change motd"
    vars:
      motd: "Hello, Netology"
    copy:
      dest: "/etc/motd"
      content: "{{ motd }}\n"
...
```

### Задание 6

Задание модифицировать playbook из 3 пункта 5 задания: 

Playbook должен в качестве приветствия установить ip адрес и hostname усправляемого хоста, пожелание хорошего дня системному администратору. 

*Приложите файл с модифицированным плейбуком и вывод выполнения.*

### Ответ:

```yaml
---
- hosts: all
  become: true
  tasks:
  - name: "Change motd"
    copy:
      dest: "/etc/motd"
      content: "{{ ansible_facts.default_ipv4.address }} {{ ansible_facts.hostname }}  Hello, {{ ansible_facts.user_id }}\n"
...
```
 ---

### Задание 7

Создайте playbook, который будет включать в себя одну, вами созданную роль.
Роль должна:

1. Установить веб сервер Apache на управляемые хосты.
2. Сконфигурировать файл index.html c выводом характеристик для каждого компьютера. Необходимо включить CPU, RAM, величину первого HDD, ip адрес.
3. Открыть порт 80 (если необходимо), запустить сервер и добавить его в автозагрузку.
4. Сделать проверку доступности веб сайта(ответ 200).

*Приложите архив с ролью и вывод выполнения.*

### Ответ:

![Task6](/lesson7_1/task6.jpg "Задание 6")

```yaml
playbook5.yaml:
---
- hosts: all
  become: true
  roles:
  - name: "Install apache"
    role: install_apache
...

install_apache/tasks/main.yml: 
---
- name: "Install apache"
  ansible.builtin.apt:
    name: "apache2"
    state: "latest"
    update_cache: true

- name: "Index.html"
  template:
    src: "index.conf.j2"
    dest: "/var/www/html/index.html"
    owner: root
    group: root
    mode: '777'

- name: "Open 80 port"
  command:
    cmd: "iptables -A INPUT -p tcp --dport 80 -j ACCEPT"

- name: "Run apache"
  service:
    name: "apache2"
    state: started
    enabled: true

- name: "Check"
  ansible.builtin.uri:
    url: http://localhost
...
```

install_apache/templates/index.conf.j2:
`CPU {{ ansible_processor }} RAM {{ ansible_memtotal_mb }} Disk size {{ ansible_facts['devices']['sda']['size'] }} IP {{ ansible_facts.default_ipv4.address }}`



