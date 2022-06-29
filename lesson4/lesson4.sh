echo Задание 2
echo 
echo Yakunichkina Aljona
echo $(date +%d-%m-%Y) - Лекция 2
cat /etc/os-release
echo 
echo
echo Задание 3
echo
rm -rf ~/yakunichkina_lesson4
mkdir -pv ~/yakunichkina_lesson4
ls -al ~
echo
echo
echo Задание 4
echo
my_folder=~/yakunichkina_lesson4_$(date +%Y-%m-%d)
rm -rf "$my_folder"
mv -v ~/yakunichkina_lesson4 "$my_folder";touch "$my_folder"/concept.1;cat /etc/os-release >"$my_folder"/concept.1;echo Якуничкина Алена >>"$my_folder"/concept.1;echo Урок 4 >>"$my_folder"/concept.1;cat "$my_folder"/concept.1 | grep Якуничкина
echo
echo
echo Задание 5
echo
sudo rm -rf /opt/my_link
sudo ln -sv "$my_folder" /opt/my_link
cp -v /opt/my_link/concept.1 /opt/my_link/concept.1.old
rm "$my_folder"/concept.1
ls "$my_folder"
echo
echo
echo Задание 6
sudo apt update
sudo apt full-upgrade
sudo apt install mc vim
