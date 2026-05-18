# Bitrix24 Call Analytics Dashboard

Интерактивная доска аналитики звонков (фронтенд), которую можно подключить к вашему endpoint с данными звонков из Bitrix24.

## Что умеет
- KPI: общее число, успешные, средняя длительность, конверсия.
- Фильтры: период, менеджер, статус, минимальная длительность.
- Графики: по дням и по менеджерам.
- Таблица последних звонков.

## Формат данных
Приложение ожидает массив звонков или объект с `data`/`calls`:

```json
[
  {
    "date": "2026-05-12T16:10:00Z",
    "manager": "Мария",
    "client": "ООО Альфа",
    "duration": 95,
    "status": "success"
  }
]
```

Также поддерживаются алиасы полей: `call_date`, `createdAt`, `assigned`, `user`, `phone`, `contact`, `duration_sec`, `result`.

## Локальный запуск
Откройте `index.html` в браузере.

## Деплой в VibeCode
1. Укажите публичный архив вашего репозитория в `deploy.sh` (`source.url`).
2. Запустите:

```bash
export VIBE_KEY='vibe_api_...'
./deploy.sh
```

> Важно: не вставляйте API ключи Bitrix24/VibeCode во фронтенд-код. Используйте серверный endpoint-прокси.

## GitHub Actions деплой (рекомендуется)
1. В GitHub репозитории откройте `Settings -> Secrets and variables -> Actions`.
2. Добавьте секрет `VIBE_CODE_MAIN` с API ключом VibeCode.
3. Запустите workflow `Deploy to VibeCode` вручную из вкладки `Actions` (или пушьте в `main`).

Workflow файл: `.github/workflows/deploy.yml`.
Он автоматически формирует `SOURCE_URL` для текущего commit (`https://github.com/<owner>/<repo>/archive/<sha>.tar.gz`) и вызывает VibeCode Deploy API для сервера `1bca73f7-c34d-4e7f-92a1-7f9aa893d67d`.

> Секреты `PORTAL_MAIN` и `VIBE_MANAGE` можно хранить в GitHub Secrets для последующих интеграций, но в текущем deploy workflow используется только `VIBE_CODE_MAIN`.


### Если в Actions предупреждение про Node.js 20
GitHub переводит JavaScript actions c Node.js 20 на Node.js 24.
В workflow уже добавлен флаг `FORCE_JAVASCRIPT_ACTIONS_TO_NODE24: true` и обновлен `actions/checkout` до `v5`, чтобы заранее использовать совместимый рантайм.

### Ошибка `VALIDATION_ERROR` с `start: Required`
Если VibeCode Deploy API отвечает `400 VALIDATION_ERROR` и пишет, что поле `start` обязательно, значит в запросе был неполный payload.

В актуальном workflow отправляется расширенный payload с обязательными полями:
- `source.url`
- `start`
- `install`
- `runtime`
- `port`
