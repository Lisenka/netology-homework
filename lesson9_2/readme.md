### Задание 1 

Установите Zabbix Server с веб-интерфейсом.

*Приложите скриншот авторизации в админке.*
*Приложите текст использованных команд в GitHub.*

### Ответ:

![Task1](/lesson9_2/task1.jpg "Задание 1")


`sudo apt install postgresql`

`wget https://repo.zabbix.com/zabbix/6.0/debian/pool/main/z/zabbix-release/zabbix-release_6.0-4%2Bdebian11_all.deb`

`dpkg -i zabbix-release_6.0-4+debian11_all.deb`

`apt update`

`sudo apt install zabbix-server-pgsql zabbix-frontend-php php7.4-pgsql zabbix-apache-conf zabbix-sql-scripts nano -y` 

`su - postgres -c 'psql --command "CREATE USER zabbix WITH PASSWORD '\'123456789\'';"'`

`su - postgres -c 'psql --command "CREATE DATABASE zabbix OWNER zabbix;"'`

`zcat /usr/share/zabbix-sql-scripts/postgresql/server.sql.gz | sudo -u zabbix psql zabbix`

`sed -i 's/# DBPassword=/DBPassword=123456789/g' /etc/zabbix/zabbix_server.conf`

`sudo systemctl restart zabbix-server apache2 # zabbix-agent`

`sudo systemctl enable zabbix-server apache2 # zabbix-agent`

---

### Задание 2 

Установите Zabbix Agent на два хоста.

*Приложите скриншот раздела Configuration > Hosts, где видно, что агенты подключены к серверу.*
*Приложите скриншот лога zabbix agent, где видно, что он работает с сервером.*
*Приложите скриншот раздела Monitoring > Latest data для обоих хостов, где видны поступающие от агентов данные.*
*Приложите текст использованных команд в GitHub.*

### Ответ:

![Task2](/lesson9_2/task2.jpg "Задание 2")
![Task2](/lesson9_2/task2_2.jpg "Задание 2")
![Task2](/lesson9_2/task2_3.jpg "Задание 2")

`wget https://repo.zabbix.com/zabbix/6.0/debian/pool/main/z/zabbix-release/zabbix-release_6.0-4%2Bdebian11_all.deb`

`dpkg -i zabbix-release_6.0-4+debian11_all.deb`

`apt update`

`sudo apt install zabbix-agent -y`

`sudo systemctl restart zabbix-agent`

`sudo systemctl enable zabbix-agent`

---

### Задание 3* 

Установите Zabbix Agent на Windows (компьютер) и подключите его к серверу Zabbix.

*Приложите скриншот раздела Latest Data, где видно свободное место на диске C:*

### Ответ:

![Task2](/lesson9_2/task3.jpg "Задание 3")

