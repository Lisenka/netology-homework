
## Задача 1: API Gateway 

Предложите решение для обеспечения реализации API Gateway. Составьте сравнительную таблицу возможностей различных программных решений. На основе таблицы сделайте выбор решения.

Решение должно соответствовать следующим требованиям:
- маршрутизация запросов к нужному сервису на основе конфигурации,
- возможность проверки аутентификационной информации в запросах,
- обеспечение терминации HTTPS.

Обоснуйте свой выбор.

### Ответ:

Для обеспечения реализации API Gateway и удовлетворения указанных требований, можно рассмотреть следующие программные решения и их возможности:

1. nginx:
- Маршрутизация запросов на основе конфигурации с использованием nginx-конфигурационных файлов.
- Встроенная поддержка проверки аутентификационной информации через модуль ngx_http_auth_request.
- Возможность терминации HTTPS.

2. Kong:
- Мощная и гибкая система управления API с возможностью настройки маршрутизации запросов.
- Возможность проверки аутентификационной информации с помощью плагинов, таких как Key Authentication или JWT.
- Поддержка терминации HTTPS с использованием проксирующего сервера, такого как nginx или Apache.

3. Tyk:
- Маршрутизация запросов на основе конфигурационной информации.
- Поддержка проверки аутентификационной информации с помощью различных механизмов авторизации, таких как API ключи или OAuth.
- Возможность терминации HTTPS.

Сравнительная таблица возможностей программных решений:

| Решение | Маршрутизация запросов | Проверка аутентификации | Терминация HTTPS |
|---------|------------------------|-------------------------|------------------|
| nginx   | Да                     | Да                      | Да               |
| Kong    | Да                     | Да                      | Да               |
| Tyk     | Да                     | Да                      | Да               |

На основе указанных требований и сравнительной таблицы, рекомендуется выбрать nginx в качестве решения для реализации API Gateway. nginx обеспечивает маршрутизацию запросов на основе конфигурационных файлов и позволяет проверять аутентификационную информацию через модуль ngx_http_auth_request. Кроме того, nginx имеет встроенную поддержку терминации HTTPS, что обеспечивает безопасное соединение с клиентом.

## Задача 2: Брокер сообщений

Составьте таблицу возможностей различных брокеров сообщений. На основе таблицы сделайте обоснованный выбор решения.

Решение должно соответствовать следующим требованиям:
- поддержка кластеризации для обеспечения надёжности,
- хранение сообщений на диске в процессе доставки,
- высокая скорость работы,
- поддержка различных форматов сообщений,
- разделение прав доступа к различным потокам сообщений,
- простота эксплуатации.

Обоснуйте свой выбор.

### Ответ:

Для сравнения возможностей различных брокеров сообщений и выбора оптимального решения, предлагаю рассмотреть следующие популярные брокеры сообщений и их возможности:

1. Apache Kafka:
- Поддержка кластеризации с репликацией данных для обеспечения надежности.
- Хранение сообщений на диске в процессе доставки, чтобы избежать потери данных при сбоях.
- Высокая скорость работы и пропускная способность для обработки большого количества сообщений.
- Поддержка различных форматов сообщений, включая бинарные данные и JSON.
- Разделение прав доступа к различным темам сообщений.
- Относительно проста в эксплуатации и настройке.

2. RabbitMQ:
- Поддержка кластеризации с репликацией данных для обеспечения надежности.
- Хранение сообщений на диске в процессе доставки.
- Высокая скорость работы и пропускная способность.
- Поддержка различных форматов сообщений, включая бинарные данные и JSON.
- Разделение прав доступа к различным очередям сообщений с помощью механизма виртуальных хостов.
- Относительно проста в эксплуатации и настройке.

3. Apache Pulsar:
- Поддержка кластеризации и шардирования для обеспечения надежности и масштабируемости.
- Хранение сообщений на диске в процессе доставки.
- Высокая скорость работы и пропускная способность.
- Поддержка различных форматов сообщений, включая бинарные данные и JSON.
- Разделение прав доступа к различным темам и подписчикам с помощью ролей и политик безопасности.
- Относительно проста в эксплуатации и настройке.

Сравнительная таблица возможностей брокеров сообщений:

| Брокер        | Кластеризация | Хранение на диске | Скорость работы | Поддержка форматов | Разделение прав | Простота эксплуатации |
|---------------|---------------|-------------------|-----------------|--------------------|-----------------|-----------------------|
| Apache Kafka  | Да            | Да                | Высокая         | Да                 | Да              | Да                    |
| RabbitMQ      | Да            | Да                | Высокая         | Да                 | Да              | Да                    |
| Apache Pulsar | Да            | Да                | Высокая         | Да                 | Да              | Да                    |

На основе указанных требований и сравнительной таблицы, рекомендуется выбрать Apache Kafka в качестве решения для брокера сообщений. Apache Kafka поддерживает необходимые функциональности, такие как кластеризация, хранение сообщений на диске, высокая скорость работы, поддержка различных форматов сообщений и разделение прав доступа. Кроме того, Kafka является популярным и широко используемым решением, что облегчает его эксплуатацию и настройку.