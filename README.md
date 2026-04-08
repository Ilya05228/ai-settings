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

# установить выбранные плагины в папку (skills/agents с неймингом plugin-name)
bash ./commands install --dest /path/to/.cursor --plugins pdf,docx,superpowers
```

## Документация

- список всех плагинов: `docs/PLUGINS.md` (генерится командой `./commands docs`)
- документация по каждому плагину: `plugins/<name>/description.md`

## TODO

- заменить skills для `pdf`, `excel`, `docx`, `pptx` (из-за лицензии в текущих)