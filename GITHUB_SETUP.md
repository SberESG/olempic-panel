# Подробная инструкция: репозиторий на GitHub и первый push

---

## Часть 1. Где взять свой username на GitHub

1. Зайдите на сайт **https://github.com** и войдите в свой аккаунт.
2. Нажмите на **свою аватарку** (круглая картинка) в **правом верхнем углу**.
3. В выпадающем меню нажмите **«Your profile»** (Ваш профиль).
4. Откроется страница профиля. **Username** — это слово в адресной строке после `github.com/`.

   **Пример:** если адрес страницы такой:
   ```
   https://github.com/sergeyshayakhmetov
   ```
   то ваш username — **sergeyshayakhmetov** (без пробелов, маленькими буквами).

5. Запомните или скопируйте этот username — он понадобится в командах ниже.

---

## Часть 2. Где открыть терминал

### Вариант A: Терминал в Cursor (или VS Code)

1. Откройте проект **olempic-panel** в Cursor (как вы уже делаете).
2. В верхнем меню выберите:
   - **Terminal** → **New Terminal**
   - или нажмите сочетание клавиш: **Ctrl + `** (клавиша с буквой «ё») или **Cmd + `** на Mac.
3. Внизу окна откроется панель с чёрным (или тёмным) экраном и строкой вроде:
   ```
   sergeyshayakhmetov@MacBook olempic-panel %
   ```
   Это и есть **терминал**. Команды нужно вводить туда и нажимать **Enter**.

### Вариант B: Терминал на Mac (без Cursor)

1. Нажмите **Cmd + Пробел**, введите **Terminal** и нажмите Enter.
2. Откроется окно терминала.
3. Перейдите в папку проекта командой (скопируйте целиком и вставьте в терминал, затем Enter):
   ```bash
   cd /Users/sergeyshayakhmetov/olempic-panel
   ```

---

## Часть 3. Создать репозиторий на сайте GitHub

1. Откройте в браузере **https://github.com** и войдите.
2. В **правом верхнем углу** нажмите на **плюс «+»**.
3. В меню выберите **«New repository»**.
4. Заполните форму:
   - **Repository name:** введите **olempic-panel** (можно скопировать).
   - **Description:** можно оставить пустым или написать, например: Doctor panel.
   - Оставьте **Public**.
   - **Не ставьте** галочки:
     - ❌ Add a README file  
     - ❌ Add .gitignore  
     - ❌ Choose a license  
   Репозиторий должен быть полностью пустым.
5. Нажмите зелёную кнопку **«Create repository»**.
6. Страница обновится — вы увидите подсказки типа «…or push an existing repository from the command line». Эту страницу можно не использовать, переходите к Части 4.

---

## Часть 4. Команды в терминале (по одной)

Откройте терминал (как в Части 2) и убедитесь, что вы в папке проекта. Если не уверены, сначала выполните:

```bash
cd /Users/sergeyshayakhmetov/olempic-panel
```

Дальше вводите команды **по одной**, после каждой нажимайте **Enter**.

**Команда 1.** Инициализировать git в папке:
```bash
git init
```

**Команда 2.** Добавить все файлы:
```bash
git add .
```

**Команда 3.** Сделать первый коммит:
```bash
git commit -m "Initial commit"
```

**Команда 4.** Назвать основную ветку main:
```bash
git branch -M main
```

**Команда 5.** Привязать ваш репозиторий на GitHub (подставьте свой username вместо YOUR_USERNAME):
```bash
git remote add origin https://github.com/YOUR_USERNAME/olempic-panel.git
```
Пример: если username **sergeyshayakhmetov**, то команда будет:
```bash
git remote add origin https://github.com/sergeyshayakhmetov/olempic-panel.git
```

**Команда 6.** Отправить код на GitHub:
```bash
git push -u origin main
```

---

## Часть 5. Если при «git push» просят логин и пароль

- **Username:** ваш GitHub username (как в Части 1).
- **Password:** это **не** пароль от входа в GitHub. Нужен **Personal Access Token**:

  1. На GitHub: нажмите аватарку → **Settings**.
  2. Слева внизу: **Developer settings** → **Personal access tokens** → **Tokens (classic)**.
  3. **Generate new token** → **Generate new token (classic)**.
  4. Note: например «vercel» или «olempic». Выберите срок (например 90 days или No expiration).
  5. Отметьте галочку **repo** (полный доступ к репозиториям).
  6. Нажмите **Generate token**. Скопируйте токен (он показывается один раз).
  7. В терминале в поле **Password** вставьте этот токен (не логин и не пароль от аккаунта).

---

## Часть 6. Проверка

1. Откройте в браузере: **https://github.com/YOUR_USERNAME/olempic-panel** (подставьте свой username).
2. Должны быть видны файлы: `dashboard.html`, `vercel.json`, папка `.github` и т.д.
3. После этого в Vercel при импорте репозиторий **olempic-panel** появится в списке.

---

## Краткая шпаргалка (когда уже знаете username)

```bash
cd /Users/sergeyshayakhmetov/olempic-panel
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/ВАШ_USERNAME/olempic-panel.git
git push -u origin main
```

Замените **ВАШ_USERNAME** на свой логин с GitHub.
