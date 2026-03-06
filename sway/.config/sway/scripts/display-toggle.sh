#!/bin/bash

STATE_FILE="$HOME/.config/sway/scripts/.display_state"

INTERNAL="eDP-1"
# Najdi první připojený externí monitor
EXTERNAL=$(swaymsg -t get_outputs | jq -r '.[] | select(.name!="'"$INTERNAL"'") | .name' | head -n1)

if [ -z "$EXTERNAL" ]; then
    notify-send "Display toggle" "Žádný externí monitor nenalezen."
    exit 1
fi

if [ ! -f "$STATE_FILE" ]; then
    echo 0 > "$STATE_FILE"
fi

STATE=$(cat "$STATE_FILE")

case "$STATE" in
    0)
        # Interní pouze
        swaymsg output "$EXTERNAL" disable
        swaymsg output "$INTERNAL" enable
        # notify-send "Display mode" "Interní displej"
        echo 1 > "$STATE_FILE"
        pkill gammastep; gammastep -O 3000 &
        ;;
    1)
        # Externí pouze
        swaymsg output "$INTERNAL" disable
        swaymsg output "$EXTERNAL" enable
        # notify-send "Display mode" "Externí displej"
        echo 2 > "$STATE_FILE"
        pkill gammastep; gammastep -O 3000 &
        ;;
    2)
        # Mirror
        swaymsg output "$INTERNAL" enable
        swaymsg output "$EXTERNAL" enable
        swaymsg output "$EXTERNAL" position 0 0
        swaymsg output "$INTERNAL" position 0 0
        # notify-send "Display mode" "Zrcadlení"
        echo 3 > "$STATE_FILE"
        pkill gammastep; gammastep -O 3000 &
        ;;
    3)
        # Extend
        RESOLUTION=$(swaymsg -t get_outputs | jq -r '.[] | select(.name=="'"$INTERNAL"'") | "\(.current_mode.width)"')
        swaymsg output "$INTERNAL" enable
        swaymsg output "$EXTERNAL" enable
        swaymsg output "$EXTERNAL" position "$RESOLUTION" 0
        # notify-send "Display mode" "Rozšířená plocha"
        echo 0 > "$STATE_FILE"
        pkill gammastep; gammastep -O 3000 &
        ;;
esac
