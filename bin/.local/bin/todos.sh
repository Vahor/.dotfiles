#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: todos.sh [N]

Print TODO-like comments added in the last N commits.
Default N: 10

Matched keywords: TODO, FIXME, HACK, NOTE, XXX, BUG
USAGE
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

commits="${1:-10}"
if ! [[ "$commits" =~ ^[1-9][0-9]*$ ]]; then
  echo "error: N must be a positive integer" >&2
  usage >&2
  exit 1
fi

keywords='TODO|FIXME|HACK|NOTE|XXX|BUG'
repo_root="$(git rev-parse --show-toplevel 2>/dev/null)" || {
  echo "error: this script must be run inside a git repository" >&2
  exit 1
}
cd "$repo_root"

# Use -U0 so each hunk only contains added/removed lines. Parse git's hunk
# headers to compute the new-file line number for each added line.
git log -n "$commits" --reverse --no-ext-diff --format='__TODO_COMMIT__%H%x09%s' -p -U0 -- . |
awk -v keywords="$keywords" '
  /^__TODO_COMMIT__/ {
    line_without_prefix = substr($0, 16)
    tab_index = index(line_without_prefix, "\t")
    commit_hash = substr(line_without_prefix, 1, tab_index - 1)
    commit_subject = substr(line_without_prefix, tab_index + 1)
    next
  }

  /^\+\+\+ b\// {
    file = substr($0, 7)
    next
  }

  /^@@ / {
    split(substr($3, 2), new_range, ",")
    line = new_range[1] - 1
    next
  }

  /^\+/ && !/^\+\+\+/ {
    line++
    text = substr($0, 2)
    if (toupper(text) ~ "(^|[^[:alnum:]_])(" keywords ")([^[:alnum:]_]|$)") {
      printf "%s:%d: %s [%s %s]\n", file, line, text, substr(commit_hash, 1, 12), commit_subject
    }
    next
  }
'
