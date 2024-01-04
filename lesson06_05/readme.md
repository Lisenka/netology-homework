### Задача 1

Используя Docker, поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.

Подключитесь к БД PostgreSQL, используя psql.

Воспользуйтесь командой \? для вывода подсказки по имеющимся в psql управляющим командам.

Найдите и приведите управляющие команды для:

вывода списка БД,
подключения к БД,
вывода списка таблиц,
вывода описания содержимого таблиц,
выхода из psql.

### Ответ:

![Task1](/lesson06_05/task1_1.jpg "Задание 1")


![Task1](/lesson06_05/task1_2.jpg "Задание 1")


![Task1](/lesson06_05/task1_3.jpg "Задание 1")


![Task1](/lesson06_05/task1_4.jpg "Задание 1")

Команды для:

вывода списка БД

`\l[+]   [PATTERN]      list databases`

подключения к БД

`\c[onnect] {[DBNAME|- USER|- HOST|- PORT|-] | conninfo}`


вывода списка таблиц

`\dt[S+] [PATTERN]`

вывода описания содержимого таблиц

`\d[S+]  NAME`

выхода из psql.

`\q`

### Задача 2

Используя psql, создайте БД test_database.

Изучите бэкап БД.

Восстановите бэкап БД в test_database.

Перейдите в управляющую консоль psql внутри контейнера.

Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.

Используя таблицу pg_stats, найдите столбец таблицы orders с наибольшим средним значением размера элементов в байтах.

Приведите в ответе команду, которую вы использовали для вычисления, и полученный результат.

### Ответ:

![Task2](/lesson06_05/task2_1.jpg "Задание 2")


![Task2](/lesson06_05/task2_2.jpg "Задание 2")


![Task2](/lesson06_05/task2_3.jpg "Задание 2")


### Задача 3

Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и поиск по ней занимает долгое время. Вам как успешному выпускнику курсов DevOps в Нетологии предложили провести разбиение таблицы на 2: шардировать на orders_1 - price>499 и orders_2 - price<=499.

Предложите SQL-транзакцию для проведения этой операции.

Можно ли было изначально исключить ручное разбиение при проектировании таблицы orders?

### Ответ:

![Task3](/lesson06_05/task3.jpg "Задание 3")

Да, изначально можно было исключить ручное разбиение при проектировании таблицы orders, если бы была использована горизонтальное шардирование. При таком подходе данные автоматически распределяются по разным шардам на основе заданного условия, что позволяет более равномерно распределить нагрузку и ускорить поиск по таблице.

### Задача 4
Используя утилиту pg_dump, создайте бекап БД test_database.

Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца title для таблиц test_database?

### Ответ:

![Task4](/lesson06_05/task4.jpg "Задание 4")


`ALTER TABLE ONLY public.orders_1
ADD CONSTRAINT title_key UNIQUE (title);`

`ALTER TABLE ONLY public.orders_2
ADD CONSTRAINT title_key UNIQUE (title);`