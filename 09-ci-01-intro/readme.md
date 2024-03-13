## Основная часть

Необходимо создать собственные workflow для двух типов задач: bug и остальные типы задач. Задачи типа bug должны проходить жизненный цикл:

1. Open -> On reproduce.
2. On reproduce -> Open, Done reproduce.
3. Done reproduce -> On fix.
4. On fix -> On reproduce, Done fix.
5. Done fix -> On test.
6. On test -> On fix, Done.
7. Done -> Closed, Open.

Остальные задачи должны проходить по упрощённому workflow:

1. Open -> On develop.
2. On develop -> Open, Done develop.
3. Done develop -> On test.
4. On test -> On develop, Done.
5. Done -> Closed, Open.

**Что нужно сделать**

1. Создайте задачу с типом bug, попытайтесь провести его по всему workflow до Done. 
1. Создайте задачу с типом epic, к ней привяжите несколько задач с типом task, проведите их по всему workflow до Done. 
1. При проведении обеих задач по статусам используйте kanban. 
1. Верните задачи в статус Open.
1. Перейдите в Scrum, запланируйте новый спринт, состоящий из задач эпика и одного бага, стартуйте спринт, проведите задачи до состояния Closed. Закройте спринт.
2. Если всё отработалось в рамках ожидания — выгрузите схемы workflow для импорта в XML. Файлы с workflow и скриншоты workflow приложите к решению задания.

---

### Решение:

![Task1](/09-ci-01-intro/task1_1.jpg "Задание 1")
![Task1](/09-ci-01-intro/task1_2.jpg "Задание 1")
![Task1](/09-ci-01-intro/task1_3.jpg "Задание 1")

![Task1](/09-ci-01-intro/task1_5.jpg "Задание 1")

Workflow для bug:
![Task1](/09-ci-01-intro/task1_4.jpg "Задание 1")
[Схема для bug](/09-ci-01-intro/Bug.xml)

Workflow для остальных задач:
![Task1](/09-ci-01-intro/task1_5.jpg "Задание 1")
[Схема для остальных задач](/09-ci-01-intro/Another%20statuses.xml)