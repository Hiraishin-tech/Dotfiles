#!/bin/bash
INTERNAL="eDP-1"
STATE_FILE="$HOME/.config/sway/scripts/.display_state"

while true; do
    sleep 2
    
    EXTERNAL_CONNECTED=$(swaymsg -t get_outputs | jq -r '.[] | select(.name!="eDP-1") | .name' | head -n1)
    
    if [ -z "$EXTERNAL_CONNECTED" ]; then
        INTERNAL_ACTIVE=$(swaymsg -t get_outputs | jq -r '.[] | select(.name=="eDP-1") | .active')
        
        if [ "$INTERNAL_ACTIVE" = "false" ]; then
            swaymsg output "$INTERNAL" enable
            echo 0 > "$STATE_FILE"
            notify-send "Display" "Externí monitor odpojen, přepnuto na interní"
            # For night light
            sleep 0.5
            pkill gammastep; gammastep -O 3000 &
        fi
    fi
done
