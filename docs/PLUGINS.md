# Плагины

| плагин | внешний | источник | описание |
|--------|---------|----------|----------|
| `_base` | `false` |  | Базовый шаблон плагина (копируй и правь). |
| `create-plugin` | `false` |  | Плагин create-plugin: создаёт новые плагины в репозитории ai-settings по шаблону (интервью, триггеры, ./commands new-plugin, skills/agents/mcp, evals, make-docs). Используй при запросах «создай плагин», «create plugin», новый локальный плагин в plugins/, оформи plugin.json и description.md, скелет как у остальных плагинов. |
| `docx` | `true` | `https://github.com/anthropics/skills.git` | Навык для работы с Word (.docx) из anthropics/skills. |
| `frontend-design` | `true` | `https://github.com/anthropics/skills.git` | Навык для фронтенд-дизайна из anthropics/skills. |
| `get-shit-done` | `true` | `https://github.com/gsd-build/get-shit-done.git` | Workflow-пак Get Shit Done (skills/agents/hooks/commands). |
| `humanizer` | `true` | `https://github.com/blader/humanizer.git` | Навык Humanizer (переписывает текст более естественно). |
| `kai-labs` | `false` |  | Локальный плагин для лабораторных работ КАИ: уточнение задания, выбор артефактов, код по умолчанию на Python, отчет в DOCX по шаблону и пошаговое пояснение результата. |
| `mcp-builder` | `true` | `https://github.com/anthropics/skills.git` | Навык для создания MCP-серверов из anthropics/skills. |
| `mcp-git` | `false` |  | MCP: git (uvx mcp-server-git). |
| `mcp-sequential-thinking` | `false` |  | MCP: sequential-thinking (@modelcontextprotocol/server-sequential-thinking). |
| `mcp-time` | `false` |  | MCP: time (uvx mcp-server-time). |
| `pdf` | `true` | `https://github.com/anthropics/skills.git` | Навык для работы с PDF из anthropics/skills. |
| `pptx` | `true` | `https://github.com/anthropics/skills.git` | Навык для работы с PowerPoint (.pptx) из anthropics/skills. |
| `programming-best-practices` | `false` |  | Локальный плагин с архитектурными практиками программирования: DDD и Clean Architecture. Подключай его, когда хочешь явно применять доменную модель, слои, границы зависимостей и другие архитектурные правила в текущей задаче. |
| `prompt-engineer` | `true` | `https://github.com/Jeffallan/claude-skills.git` | Skill Prompt Engineer из [Jeffallan/claude-skills](https://github.com/Jeffallan/claude-skills) (промпты, оценка, structured outputs, guardrails). MIT. |
| `mcp-research` | `false` |  | MCP: поиск и ресерч — Context7, DuckDuckGo, grep.app, Playwright; skill с алгоритмом выбора источника. |
| `response-language` | `false` |  | Локальный плагин для автоматического выбора языка ответа, если пользователь явно его не указал: язык определяется по доминирующему языку самой задачи, при этом код остается на английском, а комментарии пишутся на выбранном языке ответа. |
| `skill-creator` | `true` | `https://github.com/anthropics/skills.git` | Навык для создания/авторинга skills из anthropics/skills. |
| `superpowers` | `true` | `https://github.com/obra/superpowers.git` | Workflow-пак Superpowers (skills/agents/hooks). |
| `ui-ux-pro-max-skill` | `true` | `https://github.com/nextlevelbuilder/ui-ux-pro-max-skill.git` | UI/UX Pro Max skill (design intelligence, templates, scripts). |
| `xlsx` | `true` | `https://github.com/anthropics/skills.git` | Навык для работы с Excel (.xlsx) из anthropics/skills. |
