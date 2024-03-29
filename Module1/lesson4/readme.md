### Задание 1.

Подготовим рабочее пространство

1.	Скачайте с сайта [VirtualBox](https://www.virtualbox.org/) и установите на свой компьютер Virtual Box.

2.	Создайте новую виртуальную машину.

      Памяти лучше выделить не менее 2ГБ, все остальные настройки по умолчанию.

Выберите файл iso-образа Debian:

3.	Скачайте [32-разрядный (i386) дистрибутив Debian](https://cdimage.debian.org/debian-cd/current/i386/iso-cd/) с официального сайта.

4.	Установите Debian на вашу виртуальную машину.
      - имя компьютера - на ваше усмотрение
      - домен - пустое поле
      - пароль суперюзера - пустое поле
      - имя пользователя - фамилия студента строчными латинскими буквами
      - метод разметки - авто, все настройки по умолчанию
      - записать изменения на диск - выбрать вариант "да"
      - просканировать другой диск - нет
      - зеркало архива - любое
      - информация о прокси - нет
      - выбор программного обеспечения (звездочки ставятся и снимаются пробелом) - убрать сервер печати (print server), оставить (или добавить) окружение рабочего стола
      (Debian desktop environment), оставить (или добавить) стандартные системные утилиты (standard system utilities), добавить SSH server
      - загрузчик устанавливать в раздел /dev/sda

5.	Запустите виртуальную машину.

*Сделайте скриншот консоли, где в строке ввода будет ваше ФИО.*

### Результат:
![Task1](/Module1/lesson4/task1.jpg "Задание 1")

---

### Задание 2.

Подключитесь к виртуальной машине, откройте консоль и выполните следущее:

Выведите на экран:

* свою фамилию и имя латиницей;
* дату выполнения и номер лекции, разделенные дефисами;
* информацию о дистрибутиве.

*Сделайте скриншот так, чтобы был виден вывод всех команд, вставьте в документ с ДЗ.*

### Результат:
![Task2](/Module1/lesson4/task2.jpg "Задание 2")

---

### Задание 3.

Создайте каталог, имя которого будет состоять из вашей фамилии и номера лекции, в домашнем каталоге вашего пользователя.

Выведите на экран содержимое домашнего каталога, включая права на файлы, скрытые и системные файлы.

*Сделайте скриншот, вставьте в документ с ДЗ.*

### Результат:
![Task3](/Module1/lesson4/task3.jpg "Задание 3")

---

### Задание 4.

Переименуйте созданный вами каталог, добавив к нему текущую дату в формате `ГГ-ММ-ДД`;

Создайте в нем файл с именем `concept.1`, который будет содержать следующую информацию:

* а) информация о дистрибутиве,
* б) ваше имя и фамилия,
* в) номер лекции;

Выведите на экран строку с вашей фамилией. Выполните все в одну строку.

*Пришлите получившуюся команду.*

### Результат:

my_folder=~/yakunichkina_lesson4_$(date +%Y-%m-%d)

mv -v ~/yakunichkina_lesson4 "$my_folder";touch "$my_folder"/concept.1;cat /etc/os-release >"$my_folder"/concept.1;echo Якуничкина Алена >>"$my_folder"/concept.1;echo 
Урок 4 >>"$my_folder"/concept.1;cat "$my_folder"/concept.1 | grep Якуничкина

---

### Задание 5.

Создайте ссылку в `/opt` на созданный вами в предыдущем задании каталог.

Используя созданную ссылку, скопируйте `concept.1` в тот же каталог, назвав `concept.1.old`.

*Приведите команды, которыми вы это сделали.*

Удалите оригинальный файл. Выведите на экран содержимое созданного вами каталога.

*Сделайте скриншот, вставьте в документ с ДЗ.*

### Результат:

sudo rm -rf /opt/my_link

sudo ln -sv "$my_folder" /opt/my_link

cp -v /opt/my_link/concept.1 /opt/my_link/concept.1.old

rm "$my_folder"/concept.1

ls "$my_folder"


![Task5](/Module1/lesson4/task5.jpg "Задание 5")

---

### Задание 6.

Обновите список пакетов, обновите систему.

Установите на свою виртуальную машину `Midnight Commander` и `Vim` одной командой.

Выберите из списка установленных программ те, что установленны вами.

*Сделайте скриншот, вставьте в документ с ДЗ*

### Результат:
![Task6](/Module1/lesson4/task6.jpg "Задание 6")

---
[Скрипт с командами для упражнений](/Module1/lesson4/lesson4.sh/ "Скрипт")

---

### Задание 7*.

Установите на виртуальную машину **Arch Linux**. Установите программу `neofetch`. Выполните на ней задание 2 (воспользуйтесь `neofetch` для вывода информации о системе).

*Сделайте скриншот информации о системе, выведенной с помощью `neofetch`.*

### Результат:
![Task7](/Module1/lesson4/task7.jpg "Задание 7")


