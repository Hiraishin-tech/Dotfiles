#!/bin/bash
swaymsg input type:keyboard xkb_switch_layout next
LAYOUT=$(swaymsg -t get_inputs | jq -r '[.[] | select(.type=="keyboard") | .xkb_active_layout_name] | first')
notify-send -t 1500 "Keyboard layout" "$LAYOUT"
