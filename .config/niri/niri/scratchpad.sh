#!/usr/bin/env bash
# Scratchpad for niri — a floating foot terminal that auto-hides on focus loss
#
# Usage:
#   scratchpad.sh watch   — start the event-stream watcher (run at startup)
#   scratchpad.sh toggle  — summon or banish the scratchpad (bind to a key)


SCRATCHPAD_APPID="foot-scratchpad"
HIDDEN_WS="scratchpad-hidden"
LOCKFILE="/tmp/scratchpad-summoning"


get_scratchpad() {
    niri msg -j windows | jq -r ".[] | select(.app_id == \"$SCRATCHPAD_APPID\")"
}


get_focused_ws_id() {
    niri msg -j workspaces | jq '[.[] | select(.is_focused)] | first | .id'
}


get_focused_ws_idx() {
    niri msg -j workspaces | jq '[.[] | select(.is_focused)] | first | .idx'
}


hide_scratchpad() {
    local win_id
    win_id=$(get_scratchpad | jq -r '.id // empty')
    [ -z "$win_id" ] && return
    niri msg action move-window-to-workspace --window-id "$win_id" --focus false "$HIDDEN_WS"
}


show_scratchpad() {
    local win_id focused_ws_idx


    # Signal the watcher to ignore focus-loss events briefly
    touch "$LOCKFILE"


    win_id=$(get_scratchpad | jq -r '.id // empty')


    if [ -z "$win_id" ]; then
        footclient --app-id "$SCRATCHPAD_APPID" &
        sleep 0.5
        rm -f "$LOCKFILE"
        return
    fi


    focused_ws_idx=$(get_focused_ws_idx)
    niri msg action move-window-to-workspace --window-id "$win_id" --focus true "$focused_ws_idx"
    niri msg action focus-window --id "$win_id"


    # Give niri time to settle focus before the watcher resumes
    (sleep 0.5 && rm -f "$LOCKFILE") &
}


toggle_scratchpad() {
    local win_json win_id ws_id focused_ws_id
    win_json=$(get_scratchpad)
    win_id=$(echo "$win_json" | jq -r '.id // empty')


    if [ -z "$win_id" ]; then
        show_scratchpad
        return
    fi


    focused_ws_id=$(get_focused_ws_id)
    ws_id=$(echo "$win_json" | jq -r '.workspace_id // empty')


    if [ "$ws_id" = "$focused_ws_id" ]; then
        hide_scratchpad
    else
        show_scratchpad
    fi
}


watch_focus() {
    # Get the scratchpad window ID (updates when it's first created)
    local sp_id=""


    # Stream focus-change events from niri
    niri msg -j event-stream | jq --unbuffered -c '
        select(has("WindowFocusChanged"))
        | .WindowFocusChanged.id
    ' | while read -r focused_id; do
        # Skip if we're in the middle of summoning
        [ -f "$LOCKFILE" ] && continue


        # Refresh scratchpad ID if needed
        if [ -z "$sp_id" ] || ! niri msg -j windows | jq -e ".[] | select(.id == $sp_id)" &>/dev/null; then
            sp_id=$(niri msg -j windows | jq -r ".[] | select(.app_id == \"$SCRATCHPAD_APPID\") | .id // empty")
        fi
        [ -z "$sp_id" ] && continue


        # Focus moved to something else — hide scratchpad if it's on the focused workspace
        if [ "$focused_id" != "$sp_id" ]; then
            sp_ws=$(niri msg -j windows | jq -r ".[] | select(.id == $sp_id) | .workspace_id // empty")
            focused_ws=$(niri msg -j workspaces | jq '[.[] | select(.is_focused)] | first | .id')
            if [ "$sp_ws" = "$focused_ws" ]; then
                hide_scratchpad
            fi
        fi
    done
}


case "${1:-toggle}" in
    toggle) toggle_scratchpad ;;
    watch)  watch_focus ;;
    *)      echo "Usage: $0 [toggle|watch]" >&2; exit 1 ;;
esac#!/usr/bin/env bash
# Scratchpad for niri — a floating foot terminal that auto-hides on focus loss
#
# Usage:
#   scratchpad.sh watch   — start the event-stream watcher (run at startup)
#   scratchpad.sh toggle  — summon or banish the scratchpad (bind to a key)


SCRATCHPAD_APPID="foot-scratchpad"
HIDDEN_WS="scratchpad-hidden"
LOCKFILE="/tmp/scratchpad-summoning"


get_scratchpad() {
    niri msg -j windows | jq -r ".[] | select(.app_id == \"$SCRATCHPAD_APPID\")"
}


get_focused_ws_id() {
    niri msg -j workspaces | jq '[.[] | select(.is_focused)] | first | .id'
}


get_focused_ws_idx() {
    niri msg -j workspaces | jq '[.[] | select(.is_focused)] | first | .idx'
}


hide_scratchpad() {
    local win_id
    win_id=$(get_scratchpad | jq -r '.id // empty')
    [ -z "$win_id" ] && return
    niri msg action move-window-to-workspace --window-id "$win_id" --focus false "$HIDDEN_WS"
}


show_scratchpad() {
    local win_id focused_ws_idx


    # Signal the watcher to ignore focus-loss events briefly
    touch "$LOCKFILE"


    win_id=$(get_scratchpad | jq -r '.id // empty')


    if [ -z "$win_id" ]; then
        footclient --app-id "$SCRATCHPAD_APPID" &
        sleep 0.5
        rm -f "$LOCKFILE"
        return
    fi


    focused_ws_idx=$(get_focused_ws_idx)
    niri msg action move-window-to-workspace --window-id "$win_id" --focus true "$focused_ws_idx"
    niri msg action focus-window --id "$win_id"


    # Give niri time to settle focus before the watcher resumes
    (sleep 0.5 && rm -f "$LOCKFILE") &
}


toggle_scratchpad() {
    local win_json win_id ws_id focused_ws_id
    win_json=$(get_scratchpad)
    win_id=$(echo "$win_json" | jq -r '.id // empty')


    if [ -z "$win_id" ]; then
        show_scratchpad
        return
    fi


    focused_ws_id=$(get_focused_ws_id)
    ws_id=$(echo "$win_json" | jq -r '.workspace_id // empty')


    if [ "$ws_id" = "$focused_ws_id" ]; then
        hide_scratchpad
    else
        show_scratchpad
    fi
}


watch_focus() {
    # Get the scratchpad window ID (updates when it's first created)
    local sp_id=""


    # Stream focus-change events from niri
    niri msg -j event-stream | jq --unbuffered -c '
        select(has("WindowFocusChanged"))
        | .WindowFocusChanged.id
    ' | while read -r focused_id; do
        # Skip if we're in the middle of summoning
        [ -f "$LOCKFILE" ] && continue


        # Refresh scratchpad ID if needed
        if [ -z "$sp_id" ] || ! niri msg -j windows | jq -e ".[] | select(.id == $sp_id)" &>/dev/null; then
            sp_id=$(niri msg -j windows | jq -r ".[] | select(.app_id == \"$SCRATCHPAD_APPID\") | .id // empty")
        fi
        [ -z "$sp_id" ] && continue


        # Focus moved to something else — hide scratchpad if it's on the focused workspace
        if [ "$focused_id" != "$sp_id" ]; then
            sp_ws=$(niri msg -j windows | jq -r ".[] | select(.id == $sp_id) | .workspace_id // empty")
            focused_ws=$(niri msg -j workspaces | jq '[.[] | select(.is_focused)] | first | .id')
            if [ "$sp_ws" = "$focused_ws" ]; then
                hide_scratchpad
            fi
        fi
    done
}


case "${1:-toggle}" in
    toggle) toggle_scratchpad ;;
    watch)  watch_focus ;;
    *)      echo "Usage: $0 [toggle|watch]" >&2; exit 1 ;;
esac
