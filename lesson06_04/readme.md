### Задача 1
Используя Docker, поднимите инстанс MySQL (версию 8). Данные БД сохраните в volume.

Изучите бэкап БД и восстановитесь из него.

Перейдите в управляющую консоль mysql внутри контейнера.

Используя команду \h, получите список управляющих команд.

Найдите команду для выдачи статуса БД и приведите в ответе из её вывода версию сервера БД.

Подключитесь к восстановленной БД и получите список таблиц из этой БД.

Приведите в ответе количество записей с price > 300.

В следующих заданиях мы будем продолжать работу с этим контейнером.

### Ответ:

![Task1](/lesson06_04/task1_1.jpg "Задание 1")


![Task1](/lesson06_04/task1_2.jpg "Задание 1")


![Task1](/lesson06_04/task1_3.jpg "Задание 1")


![Task1](/lesson06_04/task1_4.jpg "Задание 1")


![Task1](/lesson06_04/task1_5.jpg "Задание 1")


![Task1](/lesson06_04/task1_6.jpg "Задание 1")


![Task1](/lesson06_04/task1_7.jpg "Задание 1")


![Task1](/lesson06_04/task1_8.jpg "Задание 1")


![Task1](/lesson06_04/task1_9.jpg "Задание 1")


![Task1](/lesson06_04/task1_10.jpg "Задание 1")


### Задача 2
Создайте пользователя test в БД c паролем test-pass, используя:

плагин авторизации mysql_native_password
срок истечения пароля — 180 дней
количество попыток авторизации — 3
максимальное количество запросов в час — 100
аттрибуты пользователя:
Фамилия "Pretty"
Имя "James".
Предоставьте привелегии пользователю test на операции SELECT базы test_db.

Используя таблицу INFORMATION_SCHEMA.USER_ATTRIBUTES, получите данные по пользователю test и приведите в ответе к задаче.

### Ответ:

![Task2](/lesson06_04/task2.jpg "Задание 2")

### Задача 3
Установите профилирование SET profiling = 1. Изучите вывод профилирования команд SHOW PROFILES;.

Исследуйте, какой engine используется в таблице БД test_db и приведите в ответе.

Измените engine и приведите время выполнения и запрос на изменения из профайлера в ответе:

на MyISAM,
на InnoDB.

### Ответ:

![Task3](/lesson06_04/task3.jpg "Задание 3")

### Задача 4
Изучите файл my.cnf в директории /etc/mysql.

Измените его согласно ТЗ (движок InnoDB):

скорость IO важнее сохранности данных;
нужна компрессия таблиц для экономии места на диске;
размер буффера с незакомиченными транзакциями 1 Мб;
буффер кеширования 30% от ОЗУ;
размер файла логов операций 100 Мб.
Приведите в ответе изменённый файл my.cnf.

### Ответ:

![Task4](/lesson06_04/task4.jpg "Задание 4")