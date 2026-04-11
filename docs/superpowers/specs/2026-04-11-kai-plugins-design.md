# KAI plugins design

## Goal

Add two local plugins under `plugins/`:

1. `kai-labs` for creating KAI institute laboratory work artifacts.
2. `response-language` for choosing the reply language when the user did not set it explicitly.

## Plugin 1: kai-labs

Purpose:
- Help with laboratory work for KAI.
- Start by clarifying the task, context, input materials, and desired deliverables.
- Default to Python when the programming language is not specified.
- Produce reports in `DOCX` by default.

Behavior:
- Ask for the task statement first.
- Ask for methodical materials, assignment text, source data, and expected submission format.
- Clarify whether the user needs code, spreadsheet work, a report, an explanation, a presentation, a PDF, or a combination.
- Use domain skills for `docx`, `xlsx`, `pptx`, and `pdf` tasks when appropriate.
- Ask follow-up questions if key information is missing.
- Allow web research if the task cannot be completed from the provided materials alone.
- Finish with a concise explanation of what was done, first briefly about the topic and then as a short step-by-step summary.

Report requirements:
- Use a shared report template based on the current `.docx` example file.
- Include `Цель`, `Задачи`, and `Вывод` in every report.

Packaging:
- Store the skill in `plugins/kai-labs/skills/kai-lab-assistant/`.
- Store the template in `plugins/kai-labs/skills/kai-lab-assistant/assets/`.
- Add starter evals in `plugins/kai-labs/skills/kai-lab-assistant/evals/evals.json`.

## Plugin 2: response-language

Purpose:
- Choose the reply language automatically for general tasks when the user did not explicitly specify it.

Behavior:
- Determine the dominant language of the task text.
- If more than 80% of the actual task is in one language, use that language for the reply.
- Ignore skill names, slash commands, service fragments, and web-search noise when deciding.
- Keep code, identifiers, and code-level names in English.
- Write code comments in the chosen reply language.

Packaging:
- Store the skill in `plugins/response-language/skills/response-language-selector/`.
- Add starter evals in `plugins/response-language/skills/response-language-selector/evals/evals.json`.

## Scope notes

- Both plugins are local project plugins with `external: false`.
- No MCP servers or extra agents are required for the first version.
- The focus is on strong `SKILL.md` instructions, usable descriptions, bundled assets, and starter evals.
