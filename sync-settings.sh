#!/usr/bin/env bash
# Обновляет локальные пакеты skills/agents из официальных источников.
# Идея: в git держим "ручные" файлы (например `mcp.json`), а скачиваемые подпапки — в .gitignore.
#
# Layout:
# - agents/gsd/*                      (скачивается)
# - skills/gsd/gsd-*                  (скачивается)
# - skills/office/{docx,xlsx,pptx,pdf} (скачивается)
# - skills/superpowers/*              (скачивается, если доступно)
# - skills/misc/{humanizer,mcp-builder} (скачивается/копируется)
# - get-shit-done/                    (скачивается)
# - gsd-file-manifest.json            (скачивается)
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"

echo "== workspace =="
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

echo "== ensure folders =="
mkdir -p \
  "$ROOT/agents/gsd" \
  "$ROOT/skills/gsd" \
  "$ROOT/skills/office" \
  "$ROOT/skills/superpowers" \
  "$ROOT/skills/misc"

echo "== GSD (Cursor, local) =="
mkdir -p "$TMP/gsd"
(
  cd "$TMP/gsd"
  npx -y get-shit-done-cc@latest --cursor --local
)

echo "== Sync GSD outputs =="
rm -rf "$ROOT/agents/gsd"/*
cp -a "$TMP/gsd/.cursor/agents/." "$ROOT/agents/gsd/"

rm -rf "$ROOT/skills/gsd"/*
for d in "$TMP/gsd/.cursor/skills"/gsd-*; do
  [[ -d "$d" ]] || continue
  cp -a "$d" "$ROOT/skills/gsd/"
done

rm -rf "$ROOT/get-shit-done" "$ROOT/gsd-file-manifest.json"
cp -a "$TMP/gsd/.cursor/get-shit-done" "$ROOT/get-shit-done"
if [[ -f "$TMP/gsd/.cursor/gsd-file-manifest.json" ]]; then
  cp -a "$TMP/gsd/.cursor/gsd-file-manifest.json" "$ROOT/gsd-file-manifest.json"
fi

echo "== Anthropic skills (anthropics/skills) =="
git clone --depth 1 https://github.com/anthropics/skills.git "$TMP/skills"

echo "== Office skills (Anthropic) =="
for s in docx xlsx pptx pdf; do
  rm -rf "$ROOT/skills/office/$s"
  cp -a "$TMP/skills/skills/$s" "$ROOT/skills/office/"
  echo "  + office/$s"
done

echo "== Misc skills (Anthropic) =="
rm -rf "$ROOT/skills/misc/mcp-builder"
cp -a "$TMP/skills/skills/mcp-builder" "$ROOT/skills/misc/"
echo "  + misc/mcp-builder"

echo "== Superpowers skills pack (best-effort) =="
rm -rf "$ROOT/skills/superpowers"/*
if git clone --depth 1 https://github.com/obra/superpowers.git "$TMP/superpowers" >/dev/null 2>&1; then
  if [[ -d "$TMP/superpowers/skills" ]]; then
    cp -a "$TMP/superpowers/skills/." "$ROOT/skills/superpowers/"
    echo "  + superpowers/*"
  else
    echo "  ! repo obra/superpowers не содержит папку skills/ — пропуск"
  fi
else
  echo "  ! не смог скачать obra/superpowers — пропуск"
fi

echo "== humanizer (local copy) =="
DEFAULT_HUMANIZER="$ROOT/../content-factory/.cursor/skills/humanizer"
HUMANIZER_SRC="${HUMANIZER_SRC:-$DEFAULT_HUMANIZER}"
if [[ -d "$HUMANIZER_SRC" ]]; then
  rm -rf "$ROOT/skills/misc/humanizer"
  cp -a "$HUMANIZER_SRC" "$ROOT/skills/misc/humanizer"
  echo "  + misc/humanizer (from $HUMANIZER_SRC)"
else
  echo "  ! пропуск: нет каталога $HUMANIZER_SRC — задай HUMANIZER_SRC=..."
fi

echo "Готово."
