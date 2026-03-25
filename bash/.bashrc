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

# For virsh seeing the virtual machines under $USER:
export LIBVIRT_DEFAULT_URI="qemu:///system"

# If not running interactively, don't do anything (this was default in cachyos):
[[ $- != *i* ]] && return
# PS1='[\u@\h \W]\$ '
# Change user@host to green (32) and purple (35)
# PS1='\[\e[01;35m\]\u\[\e[01;30m\]@\[\e[01;32m\]\h\[\e[00m\]:\[\e[01;34m\]\w\[\e[00m\]\$ '
# \u = username, \h = hostname, \w = current directory
PS1='\[\e[01;32m\]\u\[\e[0m\]@\[\e[01;35m\]\h\[\e[0m\]:\[\e[01;34m\]\w\[\e[0m\]\$ '

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
