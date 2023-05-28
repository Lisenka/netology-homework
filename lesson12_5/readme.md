### Задание 1

Напишите запрос к учебной базе данных, который вернёт процентное отношение общего размера всех индексов к общему размеру всех таблиц.

### Ответ:

```sql
SELECT SUM(index_length)/SUM(data_length) * 100
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'sakila'
```
### Задание 2

Выполните explain analyze следующего запроса:
```sql
select distinct concat(c.last_name, ' ', c.first_name), sum(p.amount) over (partition by c.customer_id, f.title)
from payment p, rental r, customer c, inventory i, film f
where date(p.payment_date) = '2005-07-30' and p.payment_date = r.rental_date and r.customer_id = c.customer_id and i.inventory_id = r.inventory_id
```
- перечислите узкие места;
- оптимизируйте запрос: внесите корректировки по использованию операторов, при необходимости добавьте индексы.

### Ответ:

В результате получаем такой план запроса:
```
-> Limit: 200 row(s)  (cost=0..0 rows=0) (actual time=5528..5528 rows=200 loops=1)
    -> Table scan on <temporary>  (cost=2.5..2.5 rows=0) (actual time=5528..5528 rows=200 loops=1)
        -> Temporary table with deduplication  (cost=0..0 rows=0) (actual time=5528..5528 rows=391 loops=1)
            -> Window aggregate with buffering: sum(payment.amount) OVER (PARTITION BY c.customer_id,f.title )   (actual time=2607..5359 rows=642000 loops=1)
                -> Sort: c.customer_id, f.title  (actual time=2606..2654 rows=642000 loops=1)
                    -> Stream results  (cost=10.5e+6 rows=16.1e+6) (actual time=0.241..2068 rows=642000 loops=1)
                        -> Nested loop inner join  (cost=10.5e+6 rows=16.1e+6) (actual time=0.237..1737 rows=642000 loops=1)
                            -> Nested loop inner join  (cost=8.85e+6 rows=16.1e+6) (actual time=0.234..1530 rows=642000 loops=1)
                                -> Nested loop inner join  (cost=7.24e+6 rows=16.1e+6) (actual time=0.23..1272 rows=642000 loops=1)
                                    -> Inner hash join (no condition)  (cost=1.61e+6 rows=16.1e+6) (actual time=0.22..59.3 rows=634000 loops=1)
                                        -> Filter: (cast(p.payment_date as date) = '2005-07-30')  (cost=1.68 rows=16086) (actual time=0.0202..5.04 rows=634 loops=1)
                                            -> Table scan on p  (cost=1.68 rows=16086) (actual time=0.0128..3.27 rows=16044 loops=1)
                                        -> Hash
                                            -> Covering index scan on f using idx_title  (cost=103 rows=1000) (actual time=0.0304..0.147 rows=1000 loops=1)
                                    -> Covering index lookup on r using rental_date (rental_date=p.payment_date)  (cost=0.25 rows=1) (actual time=0.0012..0.00175 rows=1.01 loops=634000)
                                -> Single-row index lookup on c using PRIMARY (customer_id=r.customer_id)  (cost=250e-6 rows=1) (actual time=217e-6..241e-6 rows=1 loops=642000)
                            -> Single-row covering index lookup on i using PRIMARY (inventory_id=r.inventory_id)  (cost=250e-6 rows=1) (actual time=124e-6..161e-6 rows=1 loops=642000)

```
Время выполнения запроса очень велико 5528.
Видно, что происходит перебор всей таблицы.


Нужно переписать запрос, используя соединения с таблицами:
```sql
SELECT concat(c.last_name, ' ', c.first_name), sum(p.amount)
FROM payment p
JOIN rental r on p.rental_id = r.rental_id
JOIN customer c on p.customer_id = c.customer_id
JOIN inventory i on r.inventory_id = i.inventory_id
JOIN film f on i.film_id = f.film_id
WHERE date(p.payment_date) = '2005-07-30'
GROUP BY p.customer_id
```

И добавить индекс по полю payment_date:
```sql
CREATE INDEX payment_date_index
ON payment (payment_date)
```
Тогда план запроса будет таким:
```
-> Limit: 200 row(s)  (cost=18958 rows=200) (actual time=0.145..7.55 rows=200 loops=1)
    -> Group aggregate: sum(p.amount)  (cost=18958 rows=599) (actual time=0.144..7.53 rows=200 loops=1)
        -> Nested loop inner join  (cost=18421 rows=5370) (actual time=0.114..7.43 rows=313 loops=1)
            -> Nested loop inner join  (cost=13863 rows=5370) (actual time=0.112..7.13 rows=313 loops=1)
                -> Nested loop inner join  (cost=9304 rows=5370) (actual time=0.109..6.17 rows=313 loops=1)
                    -> Nested loop inner join  (cost=4746 rows=5370) (actual time=0.106..5.87 rows=313 loops=1)
                        -> Filter: ((cast(p.payment_date as date) = '2005-07-30') and (p.rental_id is not null))  (cost=187 rows=5370) (actual time=0.0999..5.65 rows=313 loops=1)
                            -> Index scan on p using idx_fk_customer_id  (cost=187 rows=5370) (actual time=0.0911..5.15 rows=7694 loops=1)
                        -> Single-row index lookup on c using PRIMARY (customer_id=p.customer_id)  (cost=0.25 rows=1) (actual time=584e-6..602e-6 rows=1 loops=313)
                    -> Single-row index lookup on r using PRIMARY (rental_id=p.rental_id)  (cost=0.25 rows=1) (actual time=799e-6..817e-6 rows=1 loops=313)
                -> Single-row index lookup on i using PRIMARY (inventory_id=r.inventory_id)  (cost=0.25 rows=1) (actual time=0.00293..0.00295 rows=1 loops=313)
            -> Single-row covering index lookup on f using PRIMARY (film_id=i.film_id)  (cost=0.25 rows=1) (actual time=832e-6..851e-6 rows=1 loops=313)
```
Время выполнения значительно уменьшилось до 0,145 и теперь используются первичные ключи.

### Задание 3*

Самостоятельно изучите, какие типы индексов используются в PostgreSQL. Перечислите те индексы, которые используются в PostgreSQL, а в MySQL — нет.

*Приведите ответ в свободной форме.*

### Ответ:

Bitmap index, Reverse index, Partial index, Function based index


