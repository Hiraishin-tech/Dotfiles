# Usage
### GNU stow:
Treat individual project e.g. nvim, kitty, bash as a home directory. So if the
nvim location is in ~/.config/nvim/ then create a ~/.dotfiles/nvim/.config/nvim/
or if it's tmux, that is normally located in ~/.tmux.conf then create ~/.dotfiles/tmux/.tmux.conf
After creating the required structured path then go to ~/.dotfiles and from there
use command e.g. 'stow nvim tmux kitty' etc. to symlink the .dotfiles with the
right location in the new machine.
For unsymlinking go to ~/.dotfiles and from there use 'stow -D nvim tmux kitty'
etc.

# Requiremenets
### For Neovim:
For best experience install nerd fonts for icon support, kitty terminal (or any
that supports images in terminal), luarocks package manager, ascii-image-converter, lazygit.
For linting install python 'pip install ruff', and for JavaScript 'npm install -g @biomejs/biome'
