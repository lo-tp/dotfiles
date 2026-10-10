#!/usr/bin/env bash
#
# resume.sh — recreate the tmuxinator `resume` project inside Herdr.
#
# Source of truth: ~/.config/tmuxinator/resume.yml
#   name:  resume
#   root:  ~/Desktop/personal/project/javascript/resume
#   windows: content (single pane: vim -S $SESSION_HOME/resume.vim)
#          | cmd (main-vertical: public[git status] | server[sh run.sh])
#
# Herdr has no declarative project file, so this script drives the `herdr` CLI to
# build the equivalent workspace -> tabs -> panes layout. Tabs are relabelled in
# creation order with an index prefix (TAB_INDEX_PREFIX=1 => "2 cmd"), so the tab
# bar reads like the tmuxinator window list. Run it with:
#     bash ~/.config/tmuxinator/migration-herdr/resume.sh
#
set -euo pipefail

# ----------------------------- configuration --------------------------------
ROOT="${HOME}/Desktop/personal/project/javascript/resume"  # tmuxinator `root:`
WORKSPACE_LABEL="resume"                         # tmuxinator `name:`
SPLIT_RATIO="0.7"      # main-vertical => first (left) pane is larger.
                       # If the live result looks backwards, flip to 0.3 (or drop it).
FOCUS_AT_END=0         # 1 = focus the new workspace when done; 0 = leave your current focus
TAB_INDEX_PREFIX=1     # 1 = label tabs "<n> <name>" ("1 content" … "2 cmd"); 0 = bare names

# The `cmd` window's second pane. resume.yml still says `pnpm run dev`, but that is
# stale twice over: pnpm is not installed and this repo has no package.json. The
# project's watch loop is run.sh (rendercv), so that is what we run here.
# To go back to the literal yml value: DEV_COMMAND='pnpm run dev'
DEV_COMMAND='sh run.sh'

NVIM_SESSION="${HOME}/.config/nvim/resume.vim"   # what the `content` pane restores

# ----------------------------- preconditions -------------------------------
command -v herdr >/dev/null 2>&1 || { echo "error: 'herdr' not found in PATH" >&2; exit 1; }
command -v jq    >/dev/null 2>&1 || { echo "error: 'jq' not found in PATH"    >&2; exit 1; }
[ -d "$ROOT" ] || { echo "error: root dir not found: $ROOT" >&2; exit 1; }
# Missing session file is a soft failure: vim still opens, just without the layout.
[ -f "$NVIM_SESSION" ] || echo "warn: nvim session not found: $NVIM_SESSION" >&2

# extract a jq path from a JSON string  ->  jget '<jq path>' '<json>'
jget() { printf '%s' "$2" | jq -r "$1"; }

# name a tab in creation order, optionally with an index prefix: cmd -> "2 cmd"
TAB_INDEX=0
name_tab() { # name_tab '<tab_id>' '<name>'
  TAB_INDEX=$((TAB_INDEX + 1))
  local label="$2"
  if [ "$TAB_INDEX_PREFIX" = "1" ]; then label="$TAB_INDEX $label"; fi
  herdr tab rename "$1" "$label" >/dev/null
  printf '%s\n' "$label"
}

# guard: don't stack a second "resume" workspace (mirrors tmuxinator refusing
# to start a project that is already running).
existing="$(herdr workspace list 2>/dev/null \
  | jq -r --arg l "$WORKSPACE_LABEL" '.result.workspaces[]? | select(.label==$l) | .workspace_id' \
  || true)"
if [ -n "$existing" ]; then
  echo "error: workspace '$WORKSPACE_LABEL' already exists ($existing)." >&2
  echo "       close it (herdr workspace close $existing) or change WORKSPACE_LABEL, then re-run." >&2
  exit 1
fi

echo "==> Creating workspace '$WORKSPACE_LABEL' at $ROOT"

# ------------------- window 1: content (single pane, nvim session) ---------
ws_json="$(herdr workspace create --cwd "$ROOT" --label "$WORKSPACE_LABEL" --no-focus)"
WS_ID="$(jget '.result.workspace.workspace_id' "$ws_json")"
TAB1_ID="$(jget '.result.tab.tab_id'          "$ws_json")"
PANE_CONTENT="$(jget '.result.root_pane.pane_id' "$ws_json")"

name_tab "$TAB1_ID" "content"
herdr pane rename "$PANE_CONTENT" "content" >/dev/null
# Copied verbatim from resume.yml (single-quoted so the pane's shell sees the same
# text): the quoted "~" is NOT tilde-expanded by bash, so vim receives a literal
# "~/..." path and expands it itself. It resolves to $NVIM_SESSION. If you prefer a
# shell-correct path, use: 'export SESSION_HOME="$HOME/.config/nvim"; ...'
herdr pane run "$PANE_CONTENT" 'export SESSION_HOME="~/.config/nvim"; export VIM_SESSION=$SESSION_HOME/resume.vim; vim -S $VIM_SESSION' >/dev/null

# ------------------- window 2: cmd (main-vertical: public | server) --------
# tmuxinator lists `public` first, so it gets the wide left pane; `server` is the
# right split. To swap them, run the dev command in $PANE_PUBLIC and git in $PANE_SERVER.
tab2_json="$(herdr tab create --workspace "$WS_ID" --cwd "$ROOT" --label "cmd" --no-focus)"
TAB2_ID="$(jget '.result.tab.tab_id'          "$tab2_json")"
PANE_PUBLIC="$(jget '.result.root_pane.pane_id' "$tab2_json")"

PANE_SERVER_JSON="$(herdr pane split "$PANE_PUBLIC" --direction right --ratio "$SPLIT_RATIO" --cwd "$ROOT" --no-focus)"
PANE_SERVER="$(jget '.result.pane.pane_id' "$PANE_SERVER_JSON")"

name_tab "$TAB2_ID" "cmd"

herdr pane rename "$PANE_PUBLIC" "public" >/dev/null
herdr pane rename "$PANE_SERVER" "server" >/dev/null
herdr pane run    "$PANE_PUBLIC" "git status" >/dev/null
herdr pane run    "$PANE_SERVER" "$DEV_COMMAND" >/dev/null

if [ "$FOCUS_AT_END" = "1" ]; then
  herdr workspace focus "$WS_ID" >/dev/null
fi

# ----------------------------- summary --------------------------------------
echo "==> Done. workspace '$WORKSPACE_LABEL' ($WS_ID):"
herdr workspace list 2>/dev/null \
  | jq -r --arg l "$WORKSPACE_LABEL" \
        '.result.workspaces[] | select(.label==$l)
         | "  workspace \(.workspace_id)  tabs=\(.tab_count)  panes=\(.pane_count)  active=\(.active_tab_id)"'
echo "  tabs:"
herdr tab list --workspace "$WS_ID" 2>/dev/null \
  | jq -r '.result.tabs[]? | "    \(.tab_id)  #\(.number)  \(.label)"' || true
echo "  panes:"
herdr pane list --workspace "$WS_ID" 2>/dev/null \
  | jq -r '.result.panes[]? | "    \(.pane_id)  tab=\(.tab_id)  label=\(.label)  cwd=\(.foreground_cwd)"' || true
