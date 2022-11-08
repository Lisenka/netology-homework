### Задание 1.

Напишите регулярное выражение для проверки является ли строка `IPv4` адресом.

Для тестов можно использовать файл с содержимым:
```
192.168.0.1
127.0.0.1
84.345.23.11
88.3A.56.76
224.12.76
```

*Пришлите получившееся выражение в качестве ответа.*

### Ответ:

`[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}`


---

### Задание 2.

В Вашей конфигурации Nginx скопилось много неиспользуемых сегментов и становится сложно его читать.

Используя `sed` удалите все пустые строки и комментарии в конфигурации Nginx: 

Попробуйте сделать это одним запуском.

```
#user  nobody;
worker_processes  1;

#error_log  logs/error.log;
#error_log  logs/error.log  notice;
#error_log  logs/error.log  info;

#pid        logs/nginx.pid;


events {
    worker_connections  1024;
}


http {
    include       mime.types;
    default_type  application/octet-stream;

    #log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
    #                  '$status $body_bytes_sent "$http_referer" '
    #                  '"$http_user_agent" "$http_x_forwarded_for"';

    #access_log  logs/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    #keepalive_timeout  0;
    keepalive_timeout  65;

    #gzip  on;

    server {
        listen       80;
        server_name  localhost;

        #charset koi8-r;

        #access_log  logs/host.access.log  main;

        location / {
            root   html;
            index  index.html index.htm;
        }

        #error_page  404              /404.html;

        # redirect server error pages to the static page /50x.html
        #
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }

        # proxy the PHP scripts to Apache listening on 127.0.0.1:80
        #
        #location ~ \.php$ {
        #    proxy_pass   http://127.0.0.1;
        #}

        # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
        #
        #location ~ \.php$ {
        #    root           html;
        #    fastcgi_pass   127.0.0.1:9000;
        #    fastcgi_index  index.php;
        #    fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
        #    include        fastcgi_params;
        #}

        # deny access to .htaccess files, if Apache's document root
        # concurs with nginx's one
        #
        #location ~ /\.ht {
        #    deny  all;
        #}
    }


    # another virtual host using mix of IP-, name-, and port-based configuration
    #
    #server {
    #    listen       8000;
    #    listen       somename:8080;
    #    server_name  somename  alias  another.alias;

    #    location / {
    #        root   html;
    #        index  index.html index.htm;
    #    }
    #}


    # HTTPS server
    #
    #server {
    #    listen       443 ssl;
    #    server_name  localhost;

    #    ssl_certificate      cert.pem;
    #    ssl_certificate_key  cert.key;

    #    ssl_session_cache    shared:SSL:1m;
    #    ssl_session_timeout  5m;

    #    ssl_ciphers  HIGH:!aNULL:!MD5;
    #    ssl_prefer_server_ciphers  on;

    #    location / {
    #        root   html;
    #        index  index.html index.htm;
    #    }
    #}

}
```


*Пришлите получившуюся команду в качестве ответа*

### Ответ:

`sed -e '/^$/d' -e '/^ *#/d' nginx > nginx_res`

------

### Задание 3.

Используя `awk` и `ps aux` соберите информацию о:
 - количестве процессов для каждого пользователя;
 - процессе с самым большим PID;
 - суммарном использовании памяти различными пользователями.

*Пришлите скриншоты со скриптами и демонстрацией их работы*

### Ответ:

1. ps --sort=user aux | awk 'BEGIN {kol=1;user=""}{if (NR>2){{if ($1==user){kol++} else {if (user !="") {print user, kol}; user=$1; kol=1}}}} END {print user, kol'}
2. ps aux | awk 'BEGIN {max=0} {if (NR>1){ {if ($2>max){max=$2}} }} END {print "max PID=",max'}
3. ps --sort=user aux | awk 'BEGIN {mem=0;user=""}{if (NR>1){ {if ($1==user){mem+=$4} else {if (user !="") {print user, mem}; user=$1; mem=0}}}} END {print user, mem'}

---

### Задание 4.

Напишите bash-скрипт который собирает информацию о системе и пишет ее в лог каждые 5 секунд.

Используемые параметры:

- loadavg[1,5,15] средний показатель загрузки ЦПУ за последние 1 5 и 15 минут. *Примечание:* хранится в `/proc/loadavg`.
- memfree количество свободной оперативной памяти в байтах. *Примечание:* используем утилиту `free`.
- memtotal количество всей оперативной памяти в байтах. *Примечание:* используем утилиту `free`.
- diskfree свободное место на диске подключенного к /. *Примечание:* используем утилиту `df`.
- disktotal общий объем диска подключенного к /. *Примечание:* используем утилиту `df`.

***Формат записи:*** `timestamp loadavg1 loadavg5 loadavg15 memfree memtotal diskfree disktotal`

Пособирайте данные в течении 5-10 минут.

Анализируя этот лог с помощью `awk` напишите скрипт проверки состояния системы с заданными условиями:

- `loadavg1 < 1` в течении последних 2 минут;
- `memfree / memtotal < 60%` в течении последних 3 минут;
- `diskfree / disktotal < 60%` в течении последних 5 минут.

Скрипт должен возвращать 0 код ответа, если все условия выполняются, и любой другой в случае невыполнения.

В консоль также необходимо выводить, какое именно из условий не выполняется.

*Пришлите получившиеся скрипты в качестве ответа.*

### Ответ:

<pre><code>
#!/bin/bash

while true; do
        timestamp=$(date +"%y-%m-%d %T");
        loadavg=$(cat /proc/loadavg | awk '{print $1, $2, $3}');
        memfree=$(free | grep Mem | awk '{print $4}');
        memtotal=$(free | grep Mem | awk '{print $2}');
        diskfree=$(df | grep /$ |awk '{print $4}');
        disktotal=$(df | grep /$ |awk '{print $2}');
        echo $timestamp $loadavg $memfree $memtotal $diskfree $disktotal>>log.log;
        sleep 5;
done
            
</code></pre>

<pre><code>
#!/bin/bash

avg=$(tail -n 24 log.log| awk {'sum+=$3} END {print sum/24}');
memfree=$(tail -n 36 log.log| awk {'memfree+=($6/$7)*100} END {print memfree/36}');
diskfree=$(tail -n 60 log.log| awk {'diskfree+=($8/$9)*100} END {print diskfree/60}');

condition_avg=$(($avg > 1));
condition_memfree=$(($memfree > 60));
condition_diskfree=$(($diskfree > 60));

result=$(($condition_avg * $condition_memfree * $condition_diskfree));

if [[ $result == 0 ]]; then
        if [[ $condition_avg  = 0 ]]; then 

                echo "loadavg1 < 1";

        fi;
        if [[ $condition_memfree  = 0 ]]; then 
        
                echo "memfree / memtotal < 60%";
        
        fi;
        if [[ $condition_diskfree  =  0 ]]; then 
        
                echo "diskfree / disktotal < 60%";
        
        fi;
fi;

exit $((!$result));

</code></pre>

