#!/bin/bash
ACTION=$1

# Zkontroluj jestli je externí monitor připojený
EXTERNAL=$(swaymsg -t get_outputs | jq -r '.[] | select(.name!="eDP-1") | select(.active==true) | .name' | head -n1)

if [ -n "$EXTERNAL" ]; then
    # Externí monitor připojený – změň jas na obou
    swayosd-client --brightness "$ACTION" --device amdgpu_bl1
    CURRENT=$(ddcutil getvcp 10 --bus 7 | grep -oP 'current value =\s+\K[0-9]+')
    if [ "$ACTION" = "raise" ]; then
        ddcutil setvcp 10 $((CURRENT + 5)) --bus 7
    else
        ddcutil setvcp 10 $((CURRENT - 5)) --bus 7
    fi
else
    # Pouze interní monitor
    swayosd-client --brightness "$ACTION" --device amdgpu_bl1
fi

# Zobraz aktuální jas monitoru v procentech
INTERNAL_BRIGHTNESS=$(brightnessctl -d amdgpu_bl1 -m | cut -d',' -f4)
notify-send -t 1500 -h int:value:${INTERNAL_BRIGHTNESS//%/} "Jas" "$INTERNAL_BRIGHTNESS"
