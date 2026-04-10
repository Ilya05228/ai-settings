#!/usr/bin/env bash
set -euo pipefail

PLUGIN_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$PLUGIN_DIR/../.." && pwd)"

python3 - "$PLUGIN_DIR" <<'PY'
import json, os, shutil, subprocess, sys, tempfile
from pathlib import Path

plugin_dir = Path(sys.argv[1]).resolve()
cfg = json.loads((plugin_dir / "plugin.json").read_text(encoding="utf-8"))
up = cfg["source"]
copies = cfg["sync"]["copy"]
plugin_name = cfg.get("name") or plugin_dir.name

tmp = Path(tempfile.mkdtemp(prefix="ai-settings-plugin-"))
try:
    repo = tmp / "repo"
    subprocess.check_call(["git", "clone", "--depth", "1", up["url"], str(repo)], stdout=subprocess.DEVNULL)
    for item in copies:
        src = repo / item["from"]
        dst = plugin_dir / item["to"]
        if dst.exists():
            shutil.rmtree(dst)
        dst.parent.mkdir(parents=True, exist_ok=True)
        shutil.copytree(
            src,
            dst,
            symlinks=True,
            ignore=shutil.ignore_patterns("LICENSE", "LICENSE.*", "LICENSE.txt", "NOTICE", "NOTICE.*", "NOTICE.txt"),
        )
        git_dir = dst / ".git"
        if git_dir.exists():
            shutil.rmtree(git_dir)
    print(f"  + {plugin_name}")
finally:
    shutil.rmtree(tmp, ignore_errors=True)
PY
