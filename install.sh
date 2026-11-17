#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: ./install.sh [--codex | --all-agents] [--uninstall]

Default: link this clone to ~/.claude/skills/kinetic-ui.
  --codex             Use ~/.agents/skills/kinetic-ui instead.
  --all-agents        Install for both Claude Code and Codex.
  --uninstall         Remove only links pointing to this clone.
  --claude-dir PATH   Override the Claude Code skills directory.
  --codex-dir PATH    Override the Codex skills directory.
  --help              Show this help.

Existing directories and links to other installations are never overwritten.
USAGE
}

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
claude_dir="${HOME}/.claude/skills"
codex_dir="${HOME}/.agents/skills"
agent=claude
uninstall=false

while (($#)); do
  case "$1" in
    --codex) agent=codex; shift ;;
    --all-agents) agent=all; shift ;;
    --uninstall) uninstall=true; shift ;;
    --claude-dir|--codex-dir)
      if (($# < 2)) || [[ -z "$2" || "$2" == -* ]]; then
        printf 'Missing directory for %s\n' "$1" >&2
        exit 1
      fi
      if [[ "$1" == --claude-dir ]]; then claude_dir="$2"; else codex_dir="$2"; fi
      shift 2
      ;;
    --help|-h) usage; exit 0 ;;
    *) printf 'Unknown option: %s\n' "$1" >&2; usage >&2; exit 1 ;;
  esac
done

[[ -f "$repo_dir/SKILL.md" ]] || { printf 'SKILL.md is missing.\n' >&2; exit 1; }
targets=()
if [[ "$agent" == claude || "$agent" == all ]]; then targets+=("$claude_dir/kinetic-ui"); fi
if [[ "$agent" == codex || "$agent" == all ]]; then targets+=("$codex_dir/kinetic-ui"); fi

# Check every destination before creating or removing links.
for target in "${targets[@]}"; do
  if [[ -e "$target" || -L "$target" ]]; then
    if [[ ! -L "$target" ]] || [[ "$(readlink -- "$target")" != "$repo_dir" ]]; then
      printf 'Refusing to change an existing installation: %s\n' "$target" >&2
      exit 1
    fi
  fi
done

for target in "${targets[@]}"; do
  if $uninstall; then
    if [[ -L "$target" ]]; then
      rm -- "$target"
      printf 'Removed %s\n' "$target"
    else
      printf 'Already absent: %s\n' "$target"
    fi
  elif [[ -L "$target" ]]; then
    printf 'Already linked: %s\n' "$target"
  else
    mkdir -p -- "$(dirname -- "$target")"
    ln -s -- "$repo_dir" "$target"
    printf 'Linked %s -> %s\n' "$target" "$repo_dir"
  fi
done
