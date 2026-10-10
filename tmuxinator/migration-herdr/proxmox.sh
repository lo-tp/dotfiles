#!/usr/bin/env bash
#
# proxmox-herdr.sh — recreate the tmuxinator `proxmox` project inside Herdr.
#
# Source of truth: ~/.config/tmuxinator/proxmox.yml
#   name:  proxmox
#   root:  ~/Desktop/Personal/project/proxmox
#   windows: docker-compose | cmd (main-vertical: server|git) | nix (main-vertical: editor|shell)
#
# Herdr has no declarative project file, so this script drives the `herdr` CLI to
# build the equivalent workspace -> tabs -> panes layout. Tabs are relabelled in
# creation order with an index prefix (TAB_INDEX_PREFIX=1 => "3 nix"), so the tab
# bar reads like the tmuxinator window list. Run it with:
#     bash /tmp/proxmox-herdr.sh
#
set -euo pipefail

# ----------------------------- configuration --------------------------------
ROOT="${HOME}/Desktop/Personal/project/proxmox"   # tmuxinator `root:`
WORKSPACE_LABEL="proxmox"                          # tmuxinator `name:`
SPLIT_RATIO="0.7"      # main-vertical => first (left) pane is larger.
                       # Herdr's split --ratio isn't documented; if the live result
                       # looks backwards, flip this to 0.3 (or drop it for an even split).
FOCUS_AT_END=0         # 1 = focus the new workspace when done; 0 = leave your current focus
TAB_INDEX_PREFIX=1     # 1 = label tabs "<n> <name>" ("1 docker-compose" … "3 nix"); 0 = bare names

# ----------------------------- preconditions -------------------------------
command -v herdr >/dev/null 2>&1 || { echo "error: 'herdr' not found in PATH" >&2; exit 1; }
command -v jq    >/dev/null 2>&1 || { echo "error: 'jq' not found in PATH"    >&2; exit 1; }
[ -d "$ROOT" ] || { echo "error: root dir not found: $ROOT" >&2; exit 1; }

# extract a jq path from a JSON string  ->  jget '<jq path>' '<json>'
jget() { printf '%s' "$2" | jq -r "$1"; }

# name a tab in creation order, optionally with an index prefix: nix -> "3 nix"
TAB_INDEX=0
name_tab() { # name_tab '<tab_id>' '<name>'
  TAB_INDEX=$((TAB_INDEX + 1))
  local label="$2"
  if [ "$TAB_INDEX_PREFIX" = "1" ]; then label="$TAB_INDEX $label"; fi
  herdr tab rename "$1" "$label" >/dev/null
  printf '%s\n' "$label"
}

# guard: don't stack a second "proxmox" workspace (mirrors tmuxinator refusing
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

# ------------------- window 1: docker-compose (single pane) ----------------
ws_json="$(herdr workspace create --cwd "$ROOT" --label "$WORKSPACE_LABEL" --no-focus)"
WS_ID="$(jget '.result.workspace.workspace_id' "$ws_json")"
TAB1_ID="$(jget '.result.tab.tab_id'          "$ws_json")"
PANE_VIM="$(jget '.result.root_pane.pane_id'  "$ws_json")"

name_tab "$TAB1_ID" "docker-compose"
herdr pane rename "$PANE_VIM" "docker-compose" >/dev/null
herdr pane run   "$PANE_VIM"  'export VIM_SESSION=~/.config/nvim/session/proxmox-docker-compose.vim; vim -S $VIM_SESSION' >/dev/null

# ------------------- window 2: cmd (main-vertical: server | git) -----------
tab2_json="$(herdr tab create --workspace "$WS_ID" --cwd "$ROOT" --label "cmd" --no-focus)"
TAB2_ID="$(jget '.result.tab.tab_id'          "$tab2_json")"
PANE_SERVER="$(jget '.result.root_pane.pane_id' "$tab2_json")"

PANE_GIT_JSON="$(herdr pane split "$PANE_SERVER" --direction right --ratio "$SPLIT_RATIO" --cwd "$ROOT" --no-focus)"
PANE_GIT="$(jget '.result.pane.pane_id' "$PANE_GIT_JSON")"

name_tab "$TAB2_ID" "cmd"

herdr pane rename "$PANE_SERVER" "server" >/dev/null
herdr pane rename "$PANE_GIT"    "git"    >/dev/null
herdr pane run    "$PANE_GIT"    "git status" >/dev/null

# ------------------- window 3: nix (main-vertical: editor | shell) ---------
tab3_json="$(herdr tab create --workspace "$WS_ID" --cwd "$ROOT" --label "nix" --no-focus)"
TAB3_ID="$(jget '.result.tab.tab_id'          "$tab3_json")"
PANE_EDITOR="$(jget '.result.root_pane.pane_id' "$tab3_json")"

PANE_SHELL_JSON="$(herdr pane split "$PANE_EDITOR" --direction right --ratio "$SPLIT_RATIO" --cwd "$ROOT" --no-focus)"
PANE_SHELL="$(jget '.result.pane.pane_id' "$PANE_SHELL_JSON")"

name_tab "$TAB3_ID" "nix"

herdr pane rename "$PANE_EDITOR" "editor" >/dev/null
herdr pane rename "$PANE_SHELL"  "shell"  >/dev/null
herdr pane run    "$PANE_EDITOR" 'cd nixPlayGround' >/dev/null
# note: $(pwd) stays literal (single-quoted) exactly as in the tmuxinator file.
herdr pane run    "$PANE_SHELL"  'cd nixPlayGround; echo '\''docker run -it -v $(pwd):/workdir nixos/nix'\''' >/dev/null

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
