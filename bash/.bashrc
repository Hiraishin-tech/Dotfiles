# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi

# Bash history
HISTSIZE=100000
HISTFILESIZE=200000

unset rc
shopt -s autocd cdspell
shopt -s dotglob # for enabling mv with hidden files '.'
bind 'set completion-ignore-case on'

# Bash aliases
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases # . je jako source, ale je univerzalnejsi, funguje i v POSIX sh
fi

# if [ -f ~/fedora_logo_animated ]; then
# 	. ~/fedora_logo_animated
# fi

# Setting nvim as a default editor:
export EDITOR="nvim"
export VISUAL="nvim"
