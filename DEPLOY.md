# Автодеплой Olempic Panel

## 1. Репозиторий на GitHub

```bash
cd /Users/sergeyshayakhmetov/olempic-panel
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/olempic-panel.git
git push -u origin main
```

Замените `YOUR_USERNAME` на ваш логин GitHub. Создайте репозиторий на github.com заранее (без README).

---

## 2. Вариант A: Деплой на свой сервер (SSH)

Подходит, если панель должна лежать на том же сервере, что и API (например 52.54.172.121).

### Секреты в GitHub

Репозиторий → **Settings** → **Secrets and variables** → **Actions** → **New repository secret**:

| Имя | Описание |
|-----|----------|
| `SSH_PRIVATE_KEY` | Приватный SSH-ключ (содержимое `~/.ssh/id_rsa` или аналог). Сервер должен принимать этот ключ. |
| `REMOTE_HOST` | IP или домен сервера, например `52.54.172.121` |
| `REMOTE_USER` | Пользователь SSH, например `ubuntu` или `ec2-user` |
| `REMOTE_PATH` | Папка на сервере, куда класть файлы, например `/var/www/doctor-panel` или `/home/ubuntu/olempic-panel` |

После каждого `git push origin main` workflow скопирует `dashboard.html` в `REMOTE_PATH`.

### Одной командой на сервере (если нужен весь каталог)

Если на сервере нужно копировать не один файл, а всю папку, в `.github/workflows/deploy.yml` можно заменить шаг деплоя на свой скрипт с `rsync`/`scp` и использовать те же секреты.

---

## 3. Вариант B: Деплой в Vercel (без своего сервера)

1. Зайдите на [vercel.com](https://vercel.com), войдите через GitHub.
2. **Add New** → **Project** → выберите репозиторий `olempic-panel`.
3. Root Directory оставьте `.`, Framework Preset — **Other**. Нажмите **Deploy**.
4. После первого деплоя: **Project Settings** → скопируйте **Project ID** и **Org ID**.
5. В GitHub: **Settings** → **Secrets** → добавьте:
   - `VERCEL_TOKEN` — токен из [vercel.com/account/tokens](https://vercel.com/account/tokens)
   - `VERCEL_ORG_ID` — Org ID из настроек проекта
   - `VERCEL_PROJECT_ID` — Project ID из настроек проекта
6. В `deploy.yml` закомментируйте шаг «Deploy to server via SSH» и раскомментируйте шаг «Deploy to Vercel».
7. Сделайте `git push` — дальше деплой будет идти через Vercel (или через этот workflow, если оставите вариант B в файле).

Сайт будет по адресу вида `olempic-panel-xxx.vercel.app`. API на 52.54.172.121 должен разрешать запросы с этого домена (CORS).

---

## 4. Вариант C: Netlify

1. Зайдите на [netlify.com](https://netlify.com), войдите через GitHub.
2. **Add new site** → **Import an existing project** → выберите GitHub и репозиторий `olempic-panel`.
3. Build command оставьте пустым, Publish directory — `.` (или папка, где лежит `dashboard.html`).
4. Нажмите **Deploy**. Дальше каждый `git push` в ветку по умолчанию будет автоматически поднимать новый деплой.

Отдельный workflow в GitHub для Netlify не нужен — автодеплой уже встроен.

---

## Итог

- **Свой сервер** → вариант A (GitHub Actions + SSH).
- **Без сервера, быстро** → вариант C (Netlify) или B (Vercel).

После настройки достаточно делать `git add . && git commit -m "..." && git push`, деплой пойдёт автоматически.
