---
name: create-plugin-scaffold
description: Основной skill плагина create-plugin. Создаёт новые плагины в plugins/ репозитория ai-settings по шаблону. Используй при «создай плагин», «create plugin», добавь skill в plugins, оформи plugin.json, скелет как у других плагинов. Подключай подходы prompt-engineer и skill-creator для описаний, триггеров и evals.
---

# Create plugin

Цель: из запроса пользователя получить рабочую папку `plugins/<имя>/` с метаданными, skills и при необходимости agents или `mcp.json`.

После `./commands install` этот skill в Cursor называется `create-plugin-scaffold`.

## С чего начать

1. Уточни: назначение плагина, триггеры, состав (skills, agents, MCP), язык текстов.
2. Имя нового плагина: `a-z`, `0-9`, дефис, точка, подчёркивание; первый символ буква или цифра.
3. Работай из корня репозитория `ai-settings`, команды — `./commands`.

## Напарники

- **prompt-engineer**: `description` в `plugin.json` и YAML в `SKILL.md` — триггеры, границы, формат.
- **skill-creator**: тела skills, `evals/evals.json`, при желании `eval-viewer` из плагина skill-creator.

Если просят «без evals», сократи шаг evals, но оставь чёткий `SKILL.md` и метаданные.

## Алгоритм

### Шаг 1 — каркас

Если `plugins/<имя>/` нет:

```bash
./commands new-plugin <имя>
```

Если папка есть — не вызывай `new-plugin` повторно.

### Шаг 2 — `plugin.json`

- `name` = имя каталога.
- `external`: `false` для локального плагина.
- `description`: русский текст с настойчивыми триггерами.

### Шаг 3 — `description.md`

Кратко: состав плагина, установка `./commands install --dest ./.cursor --plugins <имя>`.

### Шаг 4 — skills

- Путь: `plugins/<имя>/skills/<каталог>/SKILL.md`.
- В YAML: `name` и `description`.
- После install имя в Cursor: `<имя-плагина>-<slug из YAML name>`.

### Шаг 5 — опционально

- **agents**: `plugins/<имя>/agents/*.md`, frontmatter `name` = stem файла.
- **MCP**: `mcp.json` с `mcpServers`.

### Шаг 6 — evals

По умолчанию `skills/<каталог>/evals/evals.json` с 2–3 промптами и `expected_output`.

### Шаг 7 — документация

```bash
./commands make-docs
```

Напомни:

```bash
./commands install --dest ./.cursor --plugins <имя>
```

## Шаблон

Ориентир: `plugins/_base/`, примеры `kai-labs`, `response-language`.

## Чеклист

- [ ] `plugin.json` и `schema/plugin.schema.json` по смыслу ок
- [ ] `description.md` заполнен
- [ ] Есть `skills/.../SKILL.md` с frontmatter
- [ ] При необходимости agents, mcp, assets
- [ ] `make-docs` выполнен или поручен пользователю
- [ ] Нет конфликта имён при install в `.cursor`
