#!/bin/bash
LOCATION_FILE="$HOME/.config/waybar/weather-location"
LOCATION=$(cat "$LOCATION_FILE" 2>/dev/null || echo "Prague")

xdg-open "https://wttr.in/${LOCATION}"
