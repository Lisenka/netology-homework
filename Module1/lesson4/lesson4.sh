### Задание 2.

#Подключитесь к виртуальной машине, откройте консоль и выполните следущее:

#Выведите на экран:

#свою фамилию и имя латиницей;
#дату выполнения и номер лекции, разделенные дефисами;
#информацию о дистрибутиве.

#Сделайте скриншот так, чтобы был виден вывод всех команд, вставьте в документ с ДЗ.

echo Задание 2
echo 
echo Yakunichkina Aljona
echo $(date +%d-%m-%Y) - Лекция 2
cat /etc/os-release
echo 
echo

### Задание 3.

#Создайте каталог, имя которого будет состоять из вашей фамилии и номера лекции, в домашнем каталоге вашего пользователя.

#Выведите на экран содержимое домашнего каталога, включая права на файлы, скрытые и системные файлы.

#Сделайте скриншот, вставьте в документ с ДЗ.

echo Задание 3
echo
mkdir -pv ~/yakunichkina_lesson4
ls -al ~
echo
echo

### Задание 4.

#Переименуйте созданный вами каталог, добавив к нему текущую дату в формате `ГГ-ММ-ДД`;

#Создайте в нем файл с именем `concept.1`, который будет содержать следующую информацию:

# а) информация о дистрибутиве,
# б) ваше имя и фамилия,
# в) номер лекции;

#Выведите на экран строку с вашей фамилией. Выполните все в одну строку.

#Пришлите получившуюся команду.

echo Задание 4
echo
my_folder=~/yakunichkina_lesson4_$(date +%Y-%m-%d)
rm -rf "$my_folder"
mv -v ~/yakunichkina_lesson4 "$my_folder";cat /etc/os-release >"$my_folder"/concept.1;echo Якуничкина Алена >>"$my_folder"/concept.1;echo Урок 4 >>"$my_folder"/concept.1;cat "$my_folder"/concept.1 | grep Якуничкина
echo
echo

### Задание 5.

#Создайте ссылку в `/opt` на созданный вами в предыдущем задании каталог.

#Используя созданную ссылку, скопируйте `concept.1` в тот же каталог, назвав `concept.1.old`.

#Приведите команды, которыми вы это сделали.*

#Удалите оригинальный файл. Выведите на экран содержимое созданного вами каталога.

#Сделайте скриншот, вставьте в документ с ДЗ.

echo Задание 5
echo
sudo rm -rf /opt/my_link
sudo ln -sv "$my_folder" /opt/my_link
cp -v /opt/my_link/concept.1 /opt/my_link/concept.1.old
rm "$my_folder"/concept.1
ls "$my_folder"
echo
echo

### Задание 6.

#Обновите список пакетов, обновите систему.

#Установите на свою виртуальную машину `Midnight Commander` и `Vim` одной командой.

#Выберите из списка установленных программ те, что установленны вами.

#Сделайте скриншот, вставьте в документ с ДЗ


echo Задание 6
sudo apt update
sudo apt full-upgrade
sudo apt install -y mc vim
dpkg --get-selections |grep mc
dpkg --get-selections |grep vim