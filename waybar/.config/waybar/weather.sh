#!/bin/bash
LOCATION_FILE="$HOME/.config/waybar/weather-location"

if [ ! -f "$LOCATION_FILE" ]; then
    echo "Prague" > "$LOCATION_FILE" # if the file doesn't exist, then set Prague as a default in weather-location file.
fi

LOCATION=$(cat "$LOCATION_FILE")
curl -s "wttr.in/${LOCATION}?format=1"
