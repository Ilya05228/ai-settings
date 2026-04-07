# Откуда что в этом `.cursor/`

Краткий реестр: что лежит в конфиге Cursor этого репозитория и откуда это взято. Обновляй вручную, если меняешь состав.

## Конфиги (ручные)

| Файл | Назначение |
|------|------------|
| `mcp.json` | MCP-серверы: команды `npx` / `uvx`, ключи через `${env:...}`. |
| `settings.json` | Включение плагина Superpowers в маркетплейсе Cursor (`plugins.superpowers.enabled`). |
| `reinstall-cursor-stack.sh` | Переустановка GSD + Anthropic skills + humanizer (см. раздел ниже). |
| `SOURCES.md` | Этот файл: реестр источников. |

## MCP-серверы (`mcp.json`)

| Имя в конфиге | Пакет / образ | Источник / заметки |
|---------------|---------------|-------------------|
| `browser-search` | `@playwright/mcp@latest` | [Microsoft Playwright MCP](https://github.com/microsoft/playwright-mcp) — автоматизация браузера. |
| `context7` | `@upstash/context7-mcp` | [Context7](https://github.com/upstash/context7) — документация библиотек; нужен `CONTEXT7_API_KEY`. |
| `git` | `uvx mcp-server-git` | Официальный [MCP git server](https://github.com/modelcontextprotocol/servers) (через uvx). |
| `sequential-thinking` | `@modelcontextprotocol/server-sequential-thinking` | Официальный пакет из [modelcontextprotocol/servers](https://github.com/modelcontextprotocol/servers). |
| `time` | `@modelcontextprotocol/server-time` | Официальный [Time MCP](https://github.com/modelcontextprotocol/servers/tree/main/src/time): текущее время и конвертация часовых поясов (IANA). |
| `duckduckgo` | `duckduckgo-mcp-server` | Сообщество npm; поиск через DuckDuckGo. |

## Плагины Cursor

| Плагин | Как ставится | Репозиторий |
|--------|----------------|-------------|
| **Superpowers** | В чате агента: `/add-plugin superpowers` (маркетплейс). Включение в `settings.json`. | [obra/superpowers](https://github.com/obra/superpowers) |

Без маркетплейса можно скопировать каталог `skills/` из того же репозитория в `.cursor/skills/` (см. README Superpowers).

## Get Shit Done (GSD)

| Что появляется | Источник |
|----------------|----------|
| `.cursor/skills/gsd-*` | [gsd-build/get-shit-done](https://github.com/gsd-build/get-shit-done) — установщик `get-shit-done-cc`. |
| `.cursor/get-shit-done/` | То же (workflows, шаблоны, `bin/gsd-tools.cjs`). |
| `.cursor/agents/gsd-*.md` | То же (промпты сабагентов). |
| `gsd-file-manifest.json` | Генерируется установщиком: версия + хеши файлов GSD для контроля целостности. |

## Остальные skills (Anthropic + свой)

Скопированы из монорепозитория **anthropics/skills** (подкаталог `skills/`):

- `docx`, `pdf`, `pptx`, `xlsx`, `frontend-design`, `mcp-builder`  
  Источник: [github.com/anthropics/skills](https://github.com/anthropics/skills/tree/main/skills)

**humanizer** — свой навык, из проекта рядом с репозиторием:

- По умолчанию при переустановке скрипт ищет: `../content-factory/.cursor/skills/humanizer`  
- Иначе задай путь: `HUMANIZER_SRC=/путь/к/humanizer`.

---

## Переустановка одной командой

Скрипт: `.cursor/reinstall-cursor-stack.sh` — подтягивает GSD локально в `.cursor/`, затем перекопирует перечисленные Anthropic-skills и `humanizer`.

Из **корня репозитория** `ilya-cursor-settings`:

```bash
bash .cursor/reinstall-cursor-stack.sh
```

или (если выставлен `chmod +x`):

```bash
./.cursor/reinstall-cursor-stack.sh
```

Свой путь к humanizer:

```bash
HUMANIZER_SRC=/home/ilya/projects/Ilya05228/content-factory/.cursor/skills/humanizer \
  bash .cursor/reinstall-cursor-stack.sh
```

Только GSD (без Anthropic и humanizer):

```bash
npx -y get-shit-done-cc@latest --cursor --local
```

Только Anthropic (после клонирования репо skills):

```bash
TMP=$(mktemp -d) && git clone --depth 1 https://github.com/anthropics/skills.git "$TMP/skills" && \
for s in frontend-design xlsx pdf docx pptx mcp-builder; do
  rm -rf ".cursor/skills/$s" && cp -a "$TMP/skills/skills/$s" .cursor/skills/
done && rm -rf "$TMP"
```

MCP и `settings.json` установщик **не трогает** — их коммить и переносить отдельно.
