## MCP servers

Каждый MCP — **отдельный плагин** `plugins/mcp-<имя>/` с файлом `mcp.json` (ровно один сервер в объекте `mcpServers`). Команда `./commands install` мержит выбранные плагины в `<dest>/mcp.json` (см. корневой `README.md`). У этих плагинов нет `sync.sh`: они локальные, только конфиг.

