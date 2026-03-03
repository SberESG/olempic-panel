# NGINX на сервере (52.54.172.121)

## Что делает этот конфиг

- Раздаёт статику панели (dashboard.html и др.) из `/var/www/olempic-panel`.
- Проксирует все запросы `/api/` на Go-бэкенд (ozzy-back-main) на порту **8080**.

## Установка

### 1. Установить NGINX (если ещё не стоит)

```bash
sudo apt update
sudo apt install -y nginx
```

### 2. Скопировать конфиг

```bash
# Из репозитория olempic-panel скопировать server/nginx.conf на сервер, например:
sudo cp /path/to/olempic-panel/server/nginx.conf /etc/nginx/sites-available/olempic
sudo ln -sf /etc/nginx/sites-available/olempic /etc/nginx/sites-enabled/
# Убрать дефолтный сайт, если мешает:
# sudo rm -f /etc/nginx/sites-enabled/default
```

### 3. Положить файлы панели

```bash
sudo mkdir -p /var/www/olempic-panel
sudo cp dashboard.html /var/www/olempic-panel/
# при необходимости остальные файлы (favicon и т.д.)
sudo chown -R www-data:www-data /var/www/olempic-panel
```

### 4. Проверить и перезагрузить NGINX

```bash
sudo nginx -t && sudo systemctl reload nginx
```

### 5. Убедиться, что бэкенд слушает 8080

Go-приложение (ozzy-back-main) должно быть запущено на порту 8080 на этом же сервере. Тогда панель будет открываться по `http://52.54.172.121/`, а API — по `http://52.54.172.121/api/`.

## HTTPS (по желанию)

Когда будет сертификат (Let's Encrypt или свой):

1. Раскомментировать в `nginx.conf` блок `server { listen 80; ... return 301 https://... }` и блок `listen 443 ssl http2` с путями к `ssl_certificate` и `ssl_certificate_key`.
2. Выполнить снова `sudo nginx -t && sudo systemctl reload nginx`.
