### Задание 1.

Дан скрипт:

```bash
#!/bin/bash
PREFIX="${1:-NOT_SET}"
INTERFACE="$2"

[[ "$PREFIX" = "NOT_SET" ]] && { echo "\$PREFIX must be passed as first positional argument"; exit 1; }
if [[ -z "$INTERFACE" ]]; then
    echo "\$INTERFACE must be passed as second positional argument"
    exit 1
fi

for SUBNET in {1..255}
do
	for HOST in {1..255}
	do
		echo "[*] IP : ${PREFIX}.${SUBNET}.${HOST}"
		arping -c 3 -i "$INTERFACE" "${PREFIX}.${SUBNET}.${HOST}" 2> /dev/null
	done
done
```

Измените скрипт так, чтобы:

- для ввода были доступны все параметры;

- была валидация вводимых параметров.


  *Приведите ответ в виде получившегося скрипта.*

### Ответ:

```bash
#!/bin/bash
INTERFACE="$1"
PREFIX="${2:-NOT_SET}"
SUBNET="${3:-NOT_SET}"
HOST="${4:-NOT_SET}"

check_prefix(){
	[[ "$1" =~ ^[0-9]{1,3}\.[0-9]{1,3}$ ]] || { echo "$1 must be like XXX.XXX"; exit 1; } 
}

check(){
	[[ "$1" =~ ^[0-9]{1,3}$ ]] || { echo "$1 must be like XXX.XXX"; exit 1; } 
}

check_interface(){
	[[ "$1" =~ ^[a-z0-9]+$ ]] || { echo "$1 must be letters and digits"; exit 1; } 
}


username=`id -nu`
if [ "$username" != "root" ]
then
        echo "Must be root to run \"`basename $0`\"."
        exit 1
fi

if [ $# -eq 0 ] ; then
        echo "Usage: $0 net-interface prefix |subnet|host" >&2
        exit 1
fi

if [ "$PREFIX" = "NOT_SET" ]; then 
         echo "prefix must be passed as second positional argument"
         exit 1
 else
	check_prefix "$PREFIX"
fi

if [ -z "$INTERFACE" ]; then
    echo "\$INTERFACE must be passed as first  positional argument"
    exit 1
else 
	check_interface "$INTERFACE"
fi

trap 'echo "Ping exit (Ctrl-C)"; exit 1' 2


if [ "$SUBNET" = "NOT_SET" ]; then
        FirstSubnet=1
        LastSubnet=255
else
	check "$SUBNET" 
	FirstSubnet=$SUBNET
        LastSubnet=$SUBNET
fi

if [ "$HOST" = "NOT_SET" ]; then
      	FirstHost=1
        LastHost=255
else
	check "$HOST"
	FirstHost=$HOST
	LastHost=$HOST
fi
                       
for (( SUBNET_i=$FirstSubnet; SUBNET_i <= $LastSubnet; SUBNET_i++ ))
do
	for (( HOST_i=$FirstHost; HOST_i <= $LastHost; HOST_i++ )) 
	do
		echo "[*] IP : ${PREFIX}.${SUBNET_i}.${HOST_i}"
		arping -c 3 -i "$INTERFACE" "${PREFIX}.${SUBNET_i}.${HOST_i}" 2> /dev/null
	done
done
```

------

### Задание 2.

Измените скрипт из Задания 1 так, чтобы:

- единственным параметром для ввода остался сетевой интерфейс;
- была валидация вводимых параметров.

### Ответ:

```bash
#!/bin/bash
INTERFACE="$1"

check_interface(){
        [[ "$1" =~ ^[a-z0-9]+$ ]] || { echo "$1 must be letters and digits"; exit 1; }
}


username=`id -nu`
if [ "$username" != "root" ]
then
        echo "Must be root to run \"`basename $0`\"."
        exit 1
fi

if [ $# -eq 0 ] ; then
        echo "Usage: $0 net-interface" >&2
        exit 1
else
        check_interface "$INTERFACE"
fi

trap 'echo "Ping exit (Ctrl-C)"; exit 1' 2

ip=$(ifconfig $INTERFACE |grep "inet " | awk '{ print $2}')
mask=$(ifconfig $INTERFACE |grep "inet " | awk '{ print $4}')

IFS='.' read -r -a ip_array <<< "$ip"
IFS='.' read -r -a mask_array <<< "$mask"

#Найдем в каком октете начинаются хосты и какой диапазон

i=0;
for oktet in ${mask_array[@]};
do
        dif=$((255-$oktet))
        new_array+=($dif)
        if [ $(($dif != 0 && $dif !=255 )) ]; then
                dif_oktet=$i
        fi
        i=$((i+1))
done

i=0;
for oktet in ${new_array[@]};
do
        if [ $oktet == 0 ]; then
                #Если разница 0, то берем из ip
                res_array+=("${ip_array[$i]}")
        elif [ $oktet == 255 ]; then
                #Если 255, то будет 0
                res_array+=(0)
        else
                first=$(("${ip_array[$i]}"/"${new_array[$i]}"))
                #Находим минимальное значение от которого будем искать первое, которое кратно 8
                for (( res=$(("${new_array[$i]}"*$first));res<"${ip_array[$i]}"; res++ ))
                do
                        if [ $((res%8)) == 0 ]; then
                                res_array+=($res)
                                break
                        fi
                done
        fi
        #Формируем массив, чтобы прибавить единицу для первого хоста
        if [ $i == $dif_oktet ]; then
                oktet_plus+=(1)
        else
                oktet_plus+=(0)
        fi

        i=$((i+1))
done

for (( first_oktet="${res_array[0]}"+"${oktet_plus[0]}"; first_oktet <= $(("${res_array[0]}"+"${new_array[0]}")); first_oktet++ ))
do
        for (( second_oktet="${res_array[1]}+"${oktet_plus[1]}""; second_oktet <= $(("${res_array[1]}"+"${new_array[1]}")); second_oktet++ ))
        do
                for (( third_oktet="${res_array[2]}+"${oktet_plus[2]}""; third_oktet <= $(("${res_array[2]}"+"${new_array[2]}")); third_oktet++ ))
                do
                        for (( fourth_oktet="${res_array[3]}+"${oktet_plus[3]}""; fourth_oktet <= $(("${res_array[3]}"+"${new_array[3]}"-1)); fourth_oktet++ ))
                        do
                                echo "[*] IP : ${first_oktet}.${second_oktet}.${third_oktet}.${fourth_oktet}"
                                arping -c 3 -i "$INTERFACE" "${first_oktet}.${second_oktet}.${third_oktet}.${fourth_oktet}" 2> /dev/null
                        done
                done
        done
done
```

