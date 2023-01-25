### Задание 1

**Напишите ответ в свободной форме, не больше одного абзаца текста.**

Установите Docker Compose и опишите, для чего он нужен и как может улучшить вашу жизнь.

### Ответ:

Docker Compose нужен, когда используется не один контейнер, а много. Он помогает "подружить" огромное количество контейнеров и избежать хаоса.

---

### Задание 2 

**Выполните действия и приложите текст конфига на этом этапе.** 

Создайте файл docker-compose.yml и внесите туда первичные настройки: 

 * version;
 * services;
 * networks.

При выполнении задания используйте подсеть 172.22.0.0.
Ваша подсеть должна называться: <ваши фамилия и инициалы>-my-netology-hw.

### Ответ:

```yaml
version: "3"
services:


networks:
  YakunichkinaEV-my-netology-nw
    driver: bridge
    ipam:
      config:
      - subnet: 172.22.0.0/24
```
---

### Задание 3 

**Выполните действия и приложите текст конфига текущего сервиса:** 

1. Установите PostgreSQL с именем контейнера <ваши фамилия и инициалы>-netology-db. 
2. Предсоздайте БД <ваши фамилия и инициалы>-db.
3. Задайте пароль пользователя postgres, как <ваши фамилия и инициалы>12!3!!
4. Пример названия контейнера: ivanovii-netology-db.
5. Назначьте для данного контейнера статический IP из подсети 172.22.0.0/24.

### Ответ:

```yaml
  netology-db:
    image: postgres
    container_name: YakunichkinaEV-netology-db
    ports:
      - 5432:5432
    volumes:
      - ./pg_data:/var/lib/postgresql/data/pgdata
    environment:
      POSTGRES_PASSWORD: YakunichkinaEV12!3!!
      POSTGRES_DB: YakunichkinaEV-db
      PGDATA: /var/lib/postgresql/data/pgdata
    networks:
      YakunichkinaEV-my-netology-nw:
        ipv4_address: 172.22.0.2
    restart: always
```
---

### Задание 4 

**Выполните действия:**

1. Установите pgAdmin с именем контейнера <ваши фамилия и инициалы>-pgadmin. 
2. Задайте логин администратора pgAdmin <ваши фамилия и инициалы>@ilove-netology.com и пароль на выбор.
3. Назначьте для данного контейнера статический IP из подсети 172.22.0.0/24.
4. Прокиньте на 80 порт контейнера порт 61231.

В качестве решения приложите:

* текст конфига текущего сервиса;
* скриншот админки pgAdmin.

### Ответ:

```yaml
  pgadmin:
    image: dpage/pgadmin4
    container_name: YakunichkinaEV-pgadmin
    environment:
      PGADMIN_DEFAULT_EMAIL: YakunichkinaEV@ilove-netology.com
      PGADMIN_DEFAULT_PASSWORD: 123
    ports:
      - "61231:80"
    networks:
      YakunichkinaEV-my-netology-nw:
        ipv4_address: 172.22.0.3
    restart: always
```
![Task4](/lesson6_4/task4.jpg "Задание 4")

---

### Задание 5 

**Выполните действия и приложите текст конфига текущего сервиса:** 

1. Установите Zabbix Server с именем контейнера <ваши фамилия и инициалы>-zabbix-netology. 
2. Настройте его подключение к вашему СУБД.
3. Назначьте для данного контейнера статический IP из подсети 172.22.0.0/24.

### Ответ:

```yaml
  zabbix-server:
    image: zabbix/zabbix-server-pgsql
    links:
      - netology-db
    container_name: YakunichkinaEV-netology-zabbix-netology
    environment:
      DB_SERVER_HOST: '172.22.0.2'
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: YakunichkinaEV12!3!!
    ports:
      - "10051:10051"
    networks:
      YakunichkinaEV-my-netology-nw:
        ipv4_address: 172.22.0.4
    restart: always
```
---

### Задание 6

**Выполните действия и приложите текст конфига текущего сервиса:** 

1. Установите Zabbix Frontend с именем контейнера <ваши фамилия и инициалы>-netology-zabbix-frontend. 
2. Настройте его подключение к вашему СУБД.
3. Назначьте для данного контейнера статический IP из подсети 172.22.0.0/24.

### Ответ:

```yaml
  zabbix_wgui:
    image: zabbix/zabbix-web-apache-pgsql
    links:
      - netology-db
      - zabbix-server
    container_name: YakunichkinaEV-netology-zabbix-frontend
    environment:
      DB_SERVER_HOST: '172.22.0.2'
      POSTGRES_USER: 'postgres'
      POSTGRES_PASSWORD: YakunichkinaEV12!3!!
      ZBX_SERVER_HOST: "zabbix_wgui"
      PHP_TZ: "Europe/Moscow"
    ports:
      - "80:8080"
      - "443:8443"
    networks:
      YakunichkinaEV-my-netology-nw:
        ipv4_address: 172.22.0.5
    restart: always
```
---

### Задание 7 

**Выполните действия.**

Настройте линки, чтобы контейнеры запускались только в момент, когда запущены контейнеры, от которых они зависят.

В качестве решения приложите:

* текст конфига **целиком**;
* скриншот команды docker ps;
* скриншот авторизации в админке Zabbix.

### Ответ:

```yaml
version: "3"
services:
  netology-db:
    image: postgres
    container_name: YakunichkinaEV-netology-db
    ports:
      - 5432:5432
    volumes:
      - ./pg_data:/var/lib/postgresql/data/pgdata
    environment:
      POSTGRES_PASSWORD: YakunichkinaEV12!3!!
      POSTGRES_DB: YakunichkinaEV-db
      PGDATA: /var/lib/postgresql/data/pgdata
    networks:
      YakunichkinaEV-my-netology-nw:
        ipv4_address: 172.22.0.2
    restart: always

  pgadmin:
    image: dpage/pgadmin4
    container_name: YakunichkinaEV-pgadmin
    environment:
      PGADMIN_DEFAULT_EMAIL: YakunichkinaEV@ilove-netology.com
      PGADMIN_DEFAULT_PASSWORD: 123
    ports:
      - "61231:80"
    networks:
      YakunichkinaEV-my-netology-nw:
        ipv4_address: 172.22.0.3
    restart: always

  zabbix-server:
    image: zabbix/zabbix-server-pgsql
    depends_on:
      - netology-db
    container_name: YakunichkinaEV-netology-zabbix-netology
    environment:
      DB_SERVER_HOST: '172.22.0.2'
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: YakunichkinaEV12!3!!
    ports:
      - "10051:10051"
    networks:
      YakunichkinaEV-my-netology-nw:
        ipv4_address: 172.22.0.4
    restart: always

  zabbix_wgui:
    image: zabbix/zabbix-web-apache-pgsql
    depends_on:
      - netology-db
      - zabbix-server
    container_name: YakunichkinaEV-netology-zabbix-frontend
    environment:
      DB_SERVER_HOST: '172.22.0.2'
      POSTGRES_USER: 'postgres'
      POSTGRES_PASSWORD: YakunichkinaEV12!3!!
      ZBX_SERVER_HOST: "zabbix_wgui"
      PHP_TZ: "Europe/Moscow"
    ports:
      - "80:8080"
      - "443:8443"
    networks:
      YakunichkinaEV-my-netology-nw:
        ipv4_address: 172.22.0.5
    restart: always

networks:
  YakunichkinaEV-my-netology-nw:
    driver: bridge
    ipam:
      config:
      - subnet: 172.22.0.0/24
```
![Task7](/lesson6_4/task7.jpg "Задание 7")

![Task7](/lesson6_4/task7_2.jpg "Задание 7")

---

### Задание 8 

**Выполните действия:** 

1. Убейте все контейнеры и потом удалите их.
1. Приложите скриншот консоли с проделанными действиями.

### Ответ:

![Task8](/lesson6_4/task8.jpg "Задание 8")

---

### Задание 9* 

Запустите свой сценарий на чистом железе без предзагруженных образов.

**Ответьте на вопросы в свободной форме:**

1. Сколько ушло времени на то, чтобы развернуть на чистом железе написанный вами сценарий?
2. Чем вы занимались в процессе создания сценария так, как это видите вы?
3. Что бы вы улучшили в сценарии развёртывания?

### Ответ:

1. Ушло примерно 2 минуты.
2. В процессе создания сценария я занималась добавлением сервисов в конфигурационный файл, указанием зависимостей одного сервиса от другого, изменением настроек, пробрасыванием портов и папок.
3. Хорошо бы указывать конкретные версии для сервисов, чтобы результат развертывания всегда был одинаковый и не зависел от обновлений ПО. Нехорошо хранить пароли в открытом виде в сценарии.

