#!/bin/bash
while true; do
    # Keyboard layout:
    LAYOUT=$(swaymsg -t get_inputs | jq -r '[.[] | select(.type=="keyboard") | .xkb_active_layout_name] | first')
    # Current date:
    # DATE=$(date +'%Y-%m-%d %X') # American date
    DATE=$(date +'%d.%m.%Y %T') # %T is the same as %H:%M:%S
    # Battery status and percentage:
    BATTERY_STATUS=$(cat /sys/class/power_supply/BAT0/status)
    BATTERY_PERCENTAGE=$(cat /sys/class/power_supply/BAT0/capacity)
    # SEND_ONCE=true
    BATTERY_TEXT=""
    # notify-send $BATTERY_PERCENTAGE
    # notify-send $BATTERY_STATUS
    if [ "$BATTERY_STATUS" = "Discharging" ]; then
        BATTERY_TEXT="🔋$BATTERY_PERCENTAGE%"
        if [[ "$BATTERY_PERCENTAGE" -lt 20 ]]; then
            BATTERY_TEXT="🪫$BATTERY_PERCENTAGE%"
            # if [ "$SEND_ONCE" = true ]: then
            # notify-send "Attention low battery, you should plug in the charger!!"
            # SEND_ONCE=false
            # fi
        fi
    else
        BATTERY_TEXT="🔋$BATTERY_PERCENTAGE% ⚡"
        if [[ "$BATTERY_STATUS" == "Full" ]]; then
           BATTERY_TEXT="🔋Full ⚡" 
        fi
    fi

    echo "$LAYOUT | $DATE | $BATTERY_TEXT |"
    sleep 0.5
done
