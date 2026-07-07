#!/bin/bash
# Renames the current tmux session to {original_name}_{claude_session_uuid}
# Run at Claude session startup to make sessions resumable after reboot.
# Usage: claude --resume <uuid> after reboot

[ -z "$TMUX" ] && exit 0

CURRENT=$(tmux display-message -p '#S')

SESSION_FILE=$(ls -t ~/.claude/sessions/*.json 2>/dev/null | awk 'NR==1{print $NF}')
[ -z "$SESSION_FILE" ] && exit 0

FULL_ID=$(python3 -c "import json; print(json.load(open('$SESSION_FILE'))['sessionId'])" 2>/dev/null)
[ -z "$FULL_ID" ] && exit 0

UUID_PATTERN='[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}'

# Strip existing UUID if present, then append current one
BASE=$(echo "$CURRENT" | sed -E "s/_${UUID_PATTERN}$//")
tmux rename-session "${BASE}_${FULL_ID}"
