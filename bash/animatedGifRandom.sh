#/bin/bash
gifDirectory="$HOME/Pictures/gifs"

shopt -s nullglob
gifs=("$gifDirectory"/*.gif)

if [ ${#gifs[@]} -eq 0 ]; then # ${#gifs[@]} returns how many items are in the array
    echo "No gifs found."
    exit 1
fi

randomGif=${gifs[RANDOM % ${#gifs[@]}]}
echo "Selected GIF: $randomGif"

clear && fastfetch --logo "$randomGif" --logo-type kitty-direct --logo-animate --logo-width 40
