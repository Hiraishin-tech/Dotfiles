#!/bin/bash
STATE_FILE="$HOME/.config/sway/scripts/.display_state"
INTERNAL="eDP-1"

# Find the first connected external monitor
EXTERNAL=$(swaymsg -t get_outputs | jq -r '.[] | select(.name!="'"$INTERNAL"'") | .name' | head -n1)

if [ -z "$EXTERNAL" ]; then
    notify-send "Display toggle" "No external monitor found."
    exit 1
fi

# Get the current state to highlight active choice
STATE=$(cat "$STATE_FILE" 2>/dev/null || echo 0) # Default state is 0
case "$STATE" in
    0) CURRENT="Internal" ;;
    1) CURRENT="External" ;;
    2) CURRENT="Mirror" ;;
    3) CURRENT="Extend" ;;
    *) CURRENT="" ;;
esac

# Menu item order – the active option will be first
CHOICES="Internal\nExternal\nMirror\nExtend"

# Choose a menu program (wofi is preffered for Wayland). But I prefer rofi :)
if command -v rofi &>/dev/null; then
    SELECTED=$(printf "$CHOICES" | rofi \
        -dmenu \
        -i \
        -p "Displej ($CURRENT):" \
        -selected-row "$STATE" \
        -theme-str '
    window {
        anchor: center;
        location: center;
        width: 50%;
        // padding: 4px;
        children: [ horibox ];
    }
    horibox {
        orientation: horizontal;
        children: [ prompt, entry, listview ];
    }
    listview {
        layout: horizontal;
        spacing: 5px;
        lines: 4;
    }
    entry {
        expand: false;
        width: 5em;
        padding: 20px 5px;
    }
    // element {
    //     padding: 10px 10px;
    // }
    // element selected {
    //     background-color: SteelBlue;
    // }
')
elif command -v wofi &>/dev/null; then # "command -v" is like which command
    SELECTED=$(printf "$CHOICES" | wofi \
        --dmenu \
        --prompt "display ($CURRENT)" \
        --width 300 \
        --height 200 \
        --cache-file /dev/null \
        --hide-scroll)
else
    notify-send "Display switch" "Install wofi or rofi for selecting display modes."
    exit 1
fi

# Cancelled / closed without selection
[ -z "$SELECTED" ] && exit 0

apply_gammastep() {
    pkill gammastep 2>/dev/null
    gammastep -O 3000 &
}

case "$SELECTED" in
    "Internal")
        swaymsg output "$EXTERNAL" disable
        swaymsg output "$INTERNAL" enable
        notify-send "Display mode" "🖥 Internal display"
        echo 0 > "$STATE_FILE"
        apply_gammastep
        ;;
    "External")
        swaymsg output "$INTERNAL" disable
        swaymsg output "$EXTERNAL" enable
        notify-send "Display mode" "🖥 External display"
        echo 1 > "$STATE_FILE"
        apply_gammastep
        ;;
    "Mirror")
        swaymsg output "$INTERNAL" enable
        swaymsg output "$EXTERNAL" enable
        swaymsg output "$EXTERNAL" position 0 0
        swaymsg output "$INTERNAL" position 0 0
        notify-send "Display mode" "⧉ Mirror"
        echo 2 > "$STATE_FILE"
        apply_gammastep
        ;;
    "Extend")
        RESOLUTION=$(swaymsg -t get_outputs | jq -r '.[] | select(.name=="'"$INTERNAL"'") | "\(.current_mode.width)"')
        swaymsg output "$INTERNAL" enable
        swaymsg output "$EXTERNAL" enable
        swaymsg output "$INTERNAL" position 0 0
        swaymsg output "$EXTERNAL" position "$RESOLUTION" 0
        notify-send "Display mode" "⬛⬛ Extend screen"
        echo 3 > "$STATE_FILE"
        apply_gammastep
        ;;
esac
