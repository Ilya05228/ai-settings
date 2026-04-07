# ai-settings

Этот репозиторий — “источник правды” для ручных настроек и скрипта установки.  
Скачиваемые пакеты кладём в **отдельные подпапки** и игнорим их точечно (а не всю `skills/`).

## Layout (что где лежит)

- `mcp.json` — ручной конфиг MCP-серверов (коммитим)
- `agents/gsd/` — агенты GSD (скачивается, в `.gitignore`)
- `skills/gsd/` — skills GSD (скачивается, в `.gitignore`)
- `skills/office/` — офисные skills (docx/xlsx/pptx/pdf) (скачивается, в `.gitignore`)
- `skills/superpowers/` — skills pack Superpowers (best-effort скачивается, в `.gitignore`)
- `skills/misc/humanizer` — локальный скилл (копируется, в `.gitignore`)
- `skills/misc/mcp-builder` — скилл Anthropic (скачивается, в `.gitignore`)
- `get-shit-done/`, `gsd-file-manifest.json` — артефакты GSD (скачивается, в `.gitignore`)

## Обновить всё одной командой

Из корня `ai-settings`:

```bash
bash ./sync-settings.sh
```

Если `humanizer` лежит не по умолчанию:

```bash
HUMANIZER_SRC=/путь/к/humanizer bash ./sync-settings.sh
```