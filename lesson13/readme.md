### Задание 1. 

Какая нотация используется для записи IPv6-адресов:

 - какие и сколько символов?
 - какие разделители?

*Приведите ответ в свободной форме.*

### Ответ:

Размер адреса составляет 128 бит, записывается в шестнадцатеричном виде. Состоит из префикса 64 бита и идентификатора интефеса 64 бита.
Всего 8 групп по 4 разряда, разделенные двоеточиями.

---

### Задание 2. 

Какой адрес используется в IPv6 как `loopback`?

*Приведите ответ в свободной форме.*

### Ответ:

0000:0000:0000:0000:0000:0000:0000:0001/128 или сокращенно ::1/128

---

### Задание 3. 

Что такое `Unicast`, `Multicast`, `Anycast` адреса?

*Приведите ответ в свободной форме.*

### Ответ:

- `Unicast` – одноадресная передача между двумя конечными узлами;
- `Multicast` – используется, когда нужно передать какую-то информацию не всем узлам а какой-то определенной группе, при этом узлы группы могут находиться в разных канальных средах;
- `Anycast` – передача единственному узлу из группы когда есть варианты прохождения запроса; задача выбрать ближайший.

---

### Задание 4. 

Используя любую консольную утилиту в Linux, получите IPv6-адрес для какого либо ресурса.

*В качестве ответа приложите скриншот выполнения команды.*

### Ответ:

![Task4](/lesson13/task4.jpg "Задание 4")

---

### Задание 5. 

 - Как выглядят IPv6-адреса, которые маршрутизируются в интернете?
 - Как выглядят локальные IPv6 адреса?

*Приведите ответ в свободной форме.*

### Ответ:

- Глобальный префикс маршрутизации 48 бит, подсеть 16 бит, идентификатор интерфейса 64 бита
- FE80, подсеть 48 бит, идентификатор интерфейса 64 бита


