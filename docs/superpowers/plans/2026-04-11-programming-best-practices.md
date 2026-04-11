# Programming Best Practices Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Создать локальный плагин `programming-best-practices` с двумя skills, `ddd` и `clean-architecture`, и встроить его в проектную документацию.

**Architecture:** Плагин будет оформлен по существующему локальному шаблону репозитория: `plugin.json`, `description.md`, `schema/plugin.schema.json`, по одному `SKILL.md` и `evals/evals.json` на каждый skill. `ddd` отвечает за доменную модель и базовые типы, `clean-architecture` отвечает за слои и зависимости; ни один skill не использует `alwaysApply`.

**Tech Stack:** Markdown, JSON, локальный CLI `./commands`, документация `docs/PLUGINS.md`

---

### Task 1: Scaffold plugin directory

**Files:**
- Create: `plugins/programming-best-practices/plugin.json`
- Create: `plugins/programming-best-practices/description.md`
- Create: `plugins/programming-best-practices/schema/plugin.schema.json`
- Create: `plugins/programming-best-practices/skills/ddd/SKILL.md`
- Create: `plugins/programming-best-practices/skills/ddd/evals/evals.json`
- Create: `plugins/programming-best-practices/skills/clean-architecture/SKILL.md`
- Create: `plugins/programming-best-practices/skills/clean-architecture/evals/evals.json`

- [ ] **Step 1: Verify `plugins/` exists before scaffolding**

Run: `ls plugins`
Expected: каталог `plugins` существует и содержит текущие плагины проекта

- [ ] **Step 2: Generate the base local plugin scaffold**

Run: `./commands new-plugin programming-best-practices`
Expected: создан каталог `plugins/programming-best-practices/` с базовыми файлами локального плагина

### Task 2: Fill plugin metadata and user-facing docs

**Files:**
- Modify: `plugins/programming-best-practices/plugin.json`
- Modify: `plugins/programming-best-practices/description.md`
- Modify: `plugins/programming-best-practices/schema/plugin.schema.json`

- [ ] **Step 1: Write final plugin metadata**

Add JSON matching the local plugin schema with:

```json
{
  "schemaVersion": 1,
  "name": "programming-best-practices",
  "external": false,
  "description": "Локальный плагин с архитектурными практиками программирования: DDD и Clean Architecture. Подключай его, когда хочешь явно применять доменную модель, слои, границы зависимостей и другие архитектурные правила в текущей задаче.",
  "sync": {
    "enabled": false,
    "script": "sync.sh"
  }
}
```

- [ ] **Step 2: Write plugin description**

Document:
- состав плагина
- разницу между `ddd` и `clean-architecture`
- установку через `./commands install --dest ./.cursor --plugins programming-best-practices`

- [ ] **Step 3: Keep schema aligned with project convention**

Ensure `schema/plugin.schema.json` contains the shared local plugin schema used by other plugins in the repository.

### Task 3: Author the `ddd` skill and evals

**Files:**
- Modify: `plugins/programming-best-practices/skills/ddd/SKILL.md`
- Modify: `plugins/programming-best-practices/skills/ddd/evals/evals.json`

- [ ] **Step 1: Write `ddd` frontmatter and scope**

Write YAML frontmatter with:

```yaml
---
name: ddd
description: Используй этот skill, когда пользователь явно просит Domain-Driven Design, богатую доменную модель, value objects, aggregates, typed id или явные доменные правила. Если skill подключен, проектируй и пиши код по правилам DDD для текущей задачи, не смешивая домен с инфраструктурой.
---
```

- [ ] **Step 2: Write the body of the `ddd` skill**

Cover:
- `Entity`, `Aggregate`, `Repository`, `DomainService`, `DomainEvent`, `UseCase`
- `Value Object` вместо примитивов
- typed id вместо сырых идентификаторов
- immutable-модели и `final`, где уместно
- опору на shared kernel / common-модуль, если он существует
- требование наследоваться от базовых доменных типов проекта, если они уже есть
- отделение домена от persistence/framework деталей

- [ ] **Step 3: Add realistic starter evals for `ddd`**

Create 2-3 prompts that explicitly ask for:
- моделирование предметной области через `Entity`, `Aggregate`, `Value Object`
- замену примитивов на доменные типы
- встраивание новой модели в существующий domain-common каркас

### Task 4: Author the `clean-architecture` skill and evals

**Files:**
- Modify: `plugins/programming-best-practices/skills/clean-architecture/SKILL.md`
- Modify: `plugins/programming-best-practices/skills/clean-architecture/evals/evals.json`

- [ ] **Step 1: Write `clean-architecture` frontmatter and scope**

Write YAML frontmatter with:

```yaml
---
name: clean-architecture
description: Используй этот skill, когда пользователь явно просит Clean Architecture, слои приложения, порты и адаптеры, границы зависимостей или отделение бизнес-логики от фреймворков. Если skill подключен, выстраивай текущую задачу по правилам Clean Architecture.
---
```

- [ ] **Step 2: Write the body of the `clean-architecture` skill**

Cover:
- внутренние и внешние слои
- направление зависимостей внутрь
- use cases / interactors
- порты, адаптеры и repository interfaces
- отсутствие утечки transport, ORM и framework деталей в ядро
- рекомендацию подключать `ddd`, если нужна богатая доменная модель

- [ ] **Step 3: Add realistic starter evals for `clean-architecture`**

Create 2-3 prompts that explicitly ask for:
- раскладку фичи по слоям
- вынос framework-зависимостей из ядра
- проектирование ports and adapters для интеграции

### Task 5: Regenerate docs and verify the result

**Files:**
- Modify: `docs/PLUGINS.md`

- [ ] **Step 1: Regenerate plugin docs**

Run: `./commands make-docs`
Expected: `docs/PLUGINS.md` обновлён и содержит `programming-best-practices`

- [ ] **Step 2: Read back generated files and sanity-check them**

Check:
- структура файлов совпадает со spec
- descriptions короткие и без `alwaysApply`
- `ddd` и `clean-architecture` не дублируют друг друга без необходимости
- evals заполнены

- [ ] **Step 3: Run lint/diagnostic check on edited files**

Run the editor diagnostics on the new and changed files.
Expected: no introduced issues
