# ai-settings

Универсальный каталог “плагинов”.

Каждый плагин — папка `plugins/<name>/` с метаданными в `plugin.json` и (опционально) своим `sync.sh`.

## Команды

Сингл-точка входа: `./commands`

```bash
# синкнуть все external-плагины
bash ./commands sync-all

# синкнуть конкретный плагин
bash ./commands sync-plugin superpowers

# создать новый плагин (копия plugins/_base)
bash ./commands new-plugin my-plugin

# сгенерировать таблицу всех плагинов
bash ./commands make-docs

# установить все плагины (все папки plugins/* с plugin.json, кроме _base) в .cursor рядом с репо:
bash ./commands install --dest ./.cursor --all
# или перечислить вручную:
bash ./commands install --dest ./.cursor --plugins docx,superpowers
# каждый скилл — папка <плагин>-<name из YAML или каталога>; агенты — <плагин>-<name>.md
```

## Документация

- список всех плагинов: `docs/PLUGINS.md` (генерится командой `./commands docs`)
- документация по каждому плагину: `plugins/<name>/description.md`
- MCP сервера (шаблоны конфигов): `mcps/`

## TODO

- заменить skills для `pdf`, `excel`, `docx`, `pptx` (из-за лицензии в текущих)