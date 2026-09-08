#!/usr/bin/env python3
"""Read-only deployment and syntax checks for supported dotfile profiles."""
import json
from pathlib import Path
import shutil
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parents[1]
PROFILES = {
    "macos": {"chezmoi": {"os": "darwin"}, "omarchy": False, "headless": False, "ephemeral": False},
    "omarchy": {"chezmoi": {"os": "linux"}, "omarchy": True, "headless": False, "ephemeral": False},
    "linux": {"chezmoi": {"os": "linux"}, "omarchy": False, "headless": False, "ephemeral": False},
    "headless-linux": {"chezmoi": {"os": "linux"}, "omarchy": False, "headless": True, "ephemeral": True},
}
FORBIDDEN = (
    ".config/systemd/", ".config/sunshine/", ".config/restic/",
    ".config/omarchy/", ".config/1Password/", ".config/hypr-rdp/",
    ".openclaw", "AGENTS.md", ".gitconfig.local", ".zshrc.local", "tests/", ".gitignore",
)

for name, data in PROFILES.items():
    base = ["chezmoi", "--source", str(ROOT), "--override-data", json.dumps(data)]
    managed = subprocess.check_output(
        base + ["managed", "--path-style", "relative", "--include", "files,symlinks"], text=True
    ).splitlines()
    paths = set(managed)
    assert not any(p.startswith(FORBIDDEN) for p in paths), (name, "host-only or repository file managed")
    assert ".config/hypr/monitors.lua" not in paths
    assert (".raycast-scripts/dev.sh" in paths) == (name == "macos"), name
    assert (".finicky.js" in paths) == (name == "macos"), name
    for p in (".config/hypr/input.lua", ".config/hypr/bindings.lua", ".config/xkb/symbols/gbmac_fixed", ".config/environment.d/ssh-agent.conf"):
        assert (p in paths) == (name == "omarchy"), (name, p)
    assert (".ssh/config" in paths) == (name in ("macos", "omarchy")), name
    assert ".config/starship.toml" in paths, name

    for source in ("private_dot_zshrc.tmpl", "dot_zprofile.tmpl", "dot_gitconfig.tmpl"):
        rendered = subprocess.check_output(
            base + ["execute-template", "--file", str(ROOT / source)], text=True
        )
        if source != "dot_gitconfig.tmpl" and shutil.which("zsh"):
            subprocess.run(["zsh", "-n"], input=rendered, text=True, check=True)
        elif source == "dot_gitconfig.tmpl":
            with tempfile.NamedTemporaryFile(mode="w", suffix=".gitconfig") as f:
                f.write(rendered)
                f.flush()
                subprocess.run(["git", "config", "--file", f.name, "--list"], stdout=subprocess.DEVNULL, check=True)
    print(f"{name}: deployment gates and template checks passed")

if not shutil.which("zsh"):
    print("zsh not installed: shell syntax checks skipped")
