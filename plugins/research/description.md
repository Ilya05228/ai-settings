## mcp-research

Один плагин, четыре MCP-сервера:

| Сервер | Назначение |
|--------|------------|
| `context7` | Актуальная документация библиотек и пакетов (нужен `CONTEXT7_API_KEY`). |
| `duckduckgo` | Поиск по открытому вебу без своего Google API. |
| `grep` | [mcp.grep.app](https://mcp.grep.app) — поиск по коду на GitHub, примеры, сигнатуры. |
| `playwright` | Открыть страницу, снимок, клики, работа с динамическим HTML/формами. |

Skill **`information-research`** описывает, **когда какой инструмент выбрать** и порядок: сначала найти источники, затем при необходимости зайти через Playwright.

Установка в Cursor: `./commands install --dest <путь> --plugins mcp-research`  
Не ставь одновременно старые плагины `mcp-context7`, `mcp-duckduckgo`, `mcp-grep`, `mcp-playwright` — будут конфликты имён в `mcp.json`.
