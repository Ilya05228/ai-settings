## create-plugin

Оркестратор создания плагинов в этом репозитории.

Что делает skill `scaffold` (после установки в Cursor: `create-plugin-scaffold`):
- интервью и уточнение требований (логика skill-creator)
- описание и триггеры (логика prompt-engineer)
- каркас `./commands new-plugin <имя>`
- заполнение `plugin.json`, `description.md`, `skills/`, при необходимости `agents/`, `mcp.json`
- стартовый `evals/evals.json` по желанию
- напоминание про `./commands make-docs` и `./commands install`

Установка в Cursor:

```bash
./commands install --dest ./.cursor --plugins create-plugin
```

В сессии желательны skills `prompt-engineer` и `skill-creator` для полного цикла.
