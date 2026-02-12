# Usage
### GNU stow:
Treat individual project e.g. nvim, kitty, bash as a home directory. So if the
nvim location is in ~/.config/nvim/ then create a ~/.dotfiles/nvim/.config/nvim/
or if it's tmux, that is normally located in ~/.tmux.conf then create
~/.dotfiles/tmux/.tmux.conf After creating the required structured path then
move the config files to the created path in Dotfiles. After that go to
~/.dotfiles and from there use command e.g. 'stow nvim tmux kitty' etc. to
symlink the .dotfiles with the right location in the new machine.
For unsymlinking go to ~/.dotfiles and from there use 'stow -D nvim tmux kitty'
etc.

# Requiremenets
### For Neovim:
For best experience install nerd fonts for icon support, kitty terminal (or any
that supports images in terminal), luarocks package manager, ascii-image-converter, lazygit.
For linting install python 'pip install ruff', and for JavaScript 'npm install -g @biomejs/biome'

### For rofi:
Install papirus-icon-theme, JetBrainsMono Nerd Font if don't have it already.

### For fastfetch with gif:
Installation guide can be find on this website: https://not4a6f7365.medium.com/animated-gifs-in-fastfetch-a905e395c765
Do this if not installed already:
Step 1:
git clone https://github.com/Maybe4a6f7365/fastfetch-gif-support.git
cd fastfetch-gif-support
mkdir build && cd build
cmake ..
make
sudo make install

Step 2:
Put some animated gifs in the "~/Pictures/gifs/". With the script ~/animatedGifRandom.sh the random gif will be selected in the directory.

Step 3 (If I would want to run a specific gif in fastfetch):
Run with my gif:
fastfetch \
 --logo ~/my-animated-logo.gif \
 --logo-type kitty-direct \
 --logo-animate

optional tweaks:
 --logo-width 40 
 --logo-padding-left 
 --logo-position top
