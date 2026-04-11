# Programming best practices design

## Goal

Добавить локальный плагин `programming-best-practices` в `plugins/` с тремя независимыми skills:

1. `ddd`
2. `clean-architecture`
3. `domain-events`

Плагин должен помогать явно подключать архитектурные практики по запросу пользователя. Эти skills не должны применяться всегда автоматически: пользователь сам решает, когда подключать `DDD`, `Clean Architecture` или оба подхода вместе.

## Plugin: programming-best-practices

Purpose:
- дать пользователю отдельный плагин для архитектурных и проектировочных практик
- не смешивать в одном skill разные паттерны, чтобы потом можно было без конфликта добавить `event-sourcing`, `cqrs`, `hexagonal` и другие подходы
- использовать простой русский язык в описаниях и правилах

Behavior:
- плагин локальный, с `external: false`
- `alwaysApply` не используется ни в одном skill
- если пользователь подключил skill, агент должен дальше вести проектирование и код по правилам этого skill в рамках текущей задачи
- если пользователь не подключал skill и не просил соответствующий паттерн явно, правила не должны навязываться

Packaging:
- `plugins/programming-best-practices/plugin.json`
- `plugins/programming-best-practices/description.md`
- `plugins/programming-best-practices/schema/plugin.schema.json`
- `plugins/programming-best-practices/skills/ddd/SKILL.md`
- `plugins/programming-best-practices/skills/ddd/evals/evals.json`
- `plugins/programming-best-practices/skills/clean-architecture/SKILL.md`
- `plugins/programming-best-practices/skills/clean-architecture/evals/evals.json`
- `plugins/programming-best-practices/skills/domain-events/SKILL.md`
- `plugins/programming-best-practices/skills/domain-events/evals/evals.json`

## Skill 1: ddd

Purpose:
- задавать правила Domain-Driven Design для моделирования предметной области
- заставлять строить доменную модель через понятные типы и явные бизнес-абстракции, а не через случайный набор примитивов и DTO

Behavior:
- использовать `Entity`, `Aggregate`, `Repository`, `DomainService`, `DomainEvent`, `UseCase` и связанные DDD-понятия там, где это уместно
- выделять `Value Object` для значимых бизнес-понятий вместо примитивов и голых строк
- использовать типизированные идентификаторы вместо `String`, `UUID`, `Long` и других сырьевых типов
- строить явную базовую иерархию типов: `ValueObject`, `IdentifierInterface`, базовый id (`LongIdentifier` и/или `UuidIdentifier`), конкретные id, `Entity`, `Aggregate`, `Repository`, `DomainService`
- держать доменную модель отдельно от persistence, framework и transport деталей
- применять неизменяемость там, где это уместно для доменной модели
- делать конкретные реализации `final` по умолчанию, если расширение не задумано специально
- использовать `Optional` для опциональных значений вместо `null`, если это соответствует языку и проектным соглашениям
- оформлять доменные ошибки отдельными типами, а не размазывать их по общим исключениям и строкам
- использовать репозитории для работы с агрегатами, а не для обхода агрегатных границ
- избегать неявных generic-типов и избыточных wildcard, когда можно выразить тип явно
- писать короткое описание ответственности класса или интерфейса над объявлением, если язык и стиль проекта это поддерживают

Required structure guidance:
- если в проекте уже есть shared kernel, common-модуль или базовые доменные типы, новые сущности и идентификаторы должны встраиваться в эту иерархию, а не дублировать её параллельными типами
- если в проекте уже существуют базовые абстракции уровня `ValueObject`, `IdentifierInterface`, `LongIdentifier`, `UuidIdentifier`, `Entity`, `Aggregate`, `Repository`, `DomainService`, надо наследоваться от них или реализовывать их
- если такого каркаса нет, нужно строить аналогичную строгую доменную модель с явными базовыми типами и понятными границами

Scope boundaries:
- skill не должен быть завязан на трейдинг, финтех или любой другой узкий домен
- skill не должен диктовать конкретный фреймворк
- правила должны быть обобщёнными и применимыми к разным языкам и проектам
- подробные правила про доменные события, буфер событий и `EventBus.publish(events)` относятся к отдельному skill `domain-events`
- правила про слои, направление зависимостей и adapters относятся в первую очередь к `clean-architecture`, а не к этому skill

## Skill 3: domain-events

Purpose:
- задавать правила для доменных событий как отдельной части DDD-модели
- объяснять смысл domain events, их форму, источник, буферизацию и публикацию

Behavior:
- доменное событие отражает существенный факт предметной области, а не технический шаг
- событие создаётся только для действительно значимых изменений
- событие не должно по умолчанию содержать весь агрегат целиком
- источник события - агрегат или доменный сервис
- агрегат хранит буфер событий
- `record(event)` регистрирует событие
- `pullDomainEvents()` возвращает накопленные события и очищает буфер
- публикация идёт после сохранения агрегата через `EventBus.publish(events)`
- если проект уже содержит базовый тип `DomainEvent`, `EventBus` и схожие контракты, новые события должны им соответствовать

Scope boundaries:
- skill не должен дублировать весь `ddd`
- skill не должен подменять `clean-architecture`
- если нужен весь каркас доменной модели, вместе с ним надо подключать `ddd`

## Skill 2: clean-architecture

Purpose:
- задавать правила Clean Architecture для разделения системы на слои и управления зависимостями
- удерживать бизнес-логику отдельно от framework, UI, transport и storage деталей

Behavior:
- разделять код на внутренние и внешние слои с понятными границами ответственности
- держать зависимости направленными внутрь, к бизнес-правилам
- считать framework и storage detail-слоями, а не ядром системы
- описывать use cases или interactors как оркестраторы сценариев
- держать интерфейсы портов, репозиториев и gateway ближе к application/domain слоям, а реализации ближе к infrastructure
- не допускать протекания HTTP, ORM, SQL, framework annotations и transport DTO в ядро бизнес-логики
- строить тесты вокруг домена, use cases, портов и boundary-контрактов
- при необходимости рекомендовать ports and adapters как рабочую форму той же архитектурной идеи

Scope boundaries:
- skill не должен подробно описывать доменную модель вместо `ddd`
- если пользователь хочет богатую доменную модель, value objects, aggregates и typed ids, надо рекомендовать подключить также `ddd`
- если подключены оба skills, `clean-architecture` отвечает за слои и зависимости, а `ddd` за модель предметной области

## Descriptions and triggering

Requirements:
- у `plugin.json` описание короткое и понятное: плагин про архитектурные практики и паттерны проектирования
- у всех `SKILL.md` frontmatter-description формулировка простая и без `alwaysApply`
- описания должны говорить, что skill нужно использовать, когда пользователь явно просит `DDD`, `Clean Architecture`, доменные события, архитектурные паттерны, богатую доменную модель, слои, зависимости или схожие практики
- описания не должны обещать автоматическое применение ко всем задачам

Expected interaction model:
- пользователь сам выбирает, когда включать `ddd`
- пользователь сам выбирает, когда включать `clean-architecture`
- пользователь сам выбирает, когда включать `domain-events`
- пользователь может включить несколько skills сразу
- если skill включён, правила этого skill для текущей задачи считаются обязательными

## Evals

Need:
- добавить стартовые `evals/evals.json` для каждого skill
- по 2-3 реалистичных prompt на каждый skill
- evals должны проверять именно ситуации, где пользователь явно просит архитектурный подход, а не случайные общие задачи

Examples of ddd eval intent:
- спроектировать доменную модель для произвольной предметной области через `Entity`, `Aggregate`, `Value Object`
- заменить примитивы и сырьевые идентификаторы на доменные типы
- встроить новые сущности в уже существующий shared domain-common каркас

Examples of clean-architecture eval intent:
- разложить фичу по слоям `domain`, `application`, `infrastructure`
- вынести framework-зависимости из ядра
- спроектировать use case, ports и adapters для внешней интеграции

Examples of domain-events eval intent:
- объяснить, что такое доменные события и когда их создавать
- спроектировать буфер событий агрегата с `record(event)` и `pullDomainEvents()`
- описать публикацию событий через `EventBus` после сохранения агрегата

## Documentation and generation

Implementation notes:
- создать плагин по локальному шаблону существующих plugins в репозитории
- после создания файлов выполнить `./commands make-docs`, чтобы обновить `docs/PLUGINS.md`
- installation section в `description.md` должна использовать команду `./commands install --dest ./.cursor --plugins programming-best-practices`

## Scope notes

- первая версия плагина не включает MCP servers, agents, scripts или assets
- первая версия ограничена тремя skills: `ddd`, `clean-architecture` и `domain-events`
- последующие паттерны должны добавляться как отдельные skills внутри того же плагина, а не путём перегрузки существующих
