### Задание 1

На лекции рассматривались режимы репликации master-slave, master-master, опишите их различия.

*Ответить в свободной форме.*

### Ответ:

В режиме master-slave один сервер является основным (master), а другой вспомогательным (slave). Изменения происходят на основном сервере и копируются на вспомогательный, с которого следует читать данные.
А режим master-master это тот же самый master-slave, только репликация происходит в обе стороны. В таком режиме повышается избыточность и эффективность при обращении с данными.

---

### Задание 2

Выполните конфигурацию master-slave репликации, примером можно пользоваться из лекции.

*Приложите скриншоты конфигурации, выполнения работы: состояния и режимы работы серверов.*

### Ответ:

---

### Задание 3* 

Выполните конфигурацию master-master репликации. Произведите проверку.

*Приложите скриншоты конфигурации, выполнения работы: состояния и режимы работы серверов.*

### Ответ: