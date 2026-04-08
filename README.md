# ai-settings

Этот репозиторий — **универсальный каталог имбовых “плагинов”**.

Есть ровно 1 скрипт: `./sync`. Он **обновляет/досоздаёт автогенерируемые части** из внешних источников

## Layout (что где лежит)

- `plugins/` — **плагины** (универсальные пакеты)
- `sync` — **единственный** скрипт синхронизации

## Что такое “plugin” в этой репе

**Plugin** — это папка `plugins/<name>/`, которая может включать:

- `**skills/`**: набор skills (например `plugins/pdf/skills/pdf/`)
- `**agents/**`: агенты/сабагенты (если ты используешь такой формат)
- `**rules/**`: правила/инструкции (например под Cursor/Claude/Codex)
- `**hooks/**`: хуки/скрипты, которые можно подключать в workflow
- `**docs/**`: документация/примеры
- `**mcp/**`: пресеты/конфиги MCP (опционально)

Цель: чтобы плагин можно было **целиком копипастить** (или подключать как подмодуль/синк) в другое окружение.

## Обновить skills одной командой

Из корня репозитория:

```bash
bash ./sync
```

## Upstreams (откуда sync берёт контент)

- `anthropics/skills` (docx/pdf/pptx/xlsx/mcp-builder/skill-creator/frontend-design): `https://github.com/anthropics/skills/tree/main/skills`
- `obra/superpowers`: `https://github.com/obra/superpowers`
- `gsd-build/get-shit-done`: `https://github.com/gsd-build/get-shit-done`
- `blader/humanizer`: `https://github.com/blader/humanizer`

## Кастомные плагины (ручные)

Создавай свои плагины прямо в `plugins/` (например `plugins/my-workflow/`).
Стартовый шаблон можно просто копировать с любого существующего плагина.