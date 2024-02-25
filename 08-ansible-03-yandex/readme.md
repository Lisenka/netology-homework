# Домашнее задание к занятию 3 «Использование Ansible»

1. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает LightHouse.
2. При создании tasks рекомендую использовать модули: `get_url`, `template`, `yum`, `apt`.
3. Tasks должны: скачать статику LightHouse, установить Nginx или любой другой веб-сервер, настроить его конфиг для открытия LightHouse, запустить веб-сервер.
4. Подготовьте свой inventory-файл `prod.yml`.
5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.
6. Попробуйте запустить playbook на этом окружении с флагом `--check`.
7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.
8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.
9. Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.
10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-03-yandex` на фиксирующий коммит, в ответ предоставьте ссылку на него.
---

### Ответ:

1. В `\inventory\prod.yml` добавляем хост для разворачивания Lighthouse
2. В `gtoup_vars` добавляем каталог для переменных, необходимых для Lighthouse
3. В `site.yml` добавляем таски для установки nginx и lighthouse

Описываем хэндлер для перезагрузки nginx.
Устанавливаем репозиторий EPEL для установки nginx на CentOS.
Устанавливает nginx

```yaml
- name: Install nginx
  hosts: lighthouse
  handlers:
    - name: Restart Nginx Service
      become: true
      ansible.builtin.service:
        name: nginx
        state: restarted
  tasks:
    - name: install EPEL repo
      become: yes
      yum: name=epel-release state=present
    - name: Install nginx
      become: yes
      ansible.builtin.yum:
        name: nginx
        state: present
        update_cache: true
      notify: restart nginx service
```

Формируем Nginx конфиг по шаблону.
```yaml
    - name: Create Nginx config | Install Nginx
      become: true
      template:
        src: nginx.j2
        dest: /etc/nginx/nginx.conf
        mode: 0644
      notify: Restart Nginx service
```
Перед выполнением таски устанавливаем unzip
```yaml
- name: Install lighthouse
  hosts: lighthouse
  handlers:
    - name: Restart nginx service
      become: true
      ansible.builtin.service:
        name: nginx
        state: restarted
  pre_tasks:
    - name: Install unzip
      become: true
      ansible.builtin.yum:
        name: unzip
        state: present
        update_cache: true
```
Скачиваем архив lighthouse.
Создаем директорию для распаковки lighthouse.
Распаковываем lighthouse.

```yaml
  tasks:
    - name: Get lighthouse distrub
      ansible.builtin.get_url:
        url: "https://github.com/VKCOM/lighthouse/archive/refs/heads/master.zip"
        dest: "./lighthouse.zip"
        mode: "0644"
    - name: Directory
      ansible.builtin.file:
        path: "{{ lighthouse_dir }}"
        state: directory
        recurse: true
        mode: "0755"
      become: true
    - name: Unarchive lighthouse
      become: true
      ansible.builtin.unarchive:
        src: "./lighthouse.zip"
        dest: "{{ lighthouse_dir }}"
        remote_src: true
```
Создаем кофиг для lighthouse по шаблону.
```yaml
    - name: Create lighthouse config
      become: true
      template:
        src: lighthouse.j2
        dest: /etc/nginx/conf.d/default.conf
        mode: 0644
      notify: Restart nginx service
```