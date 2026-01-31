###############################################################################
#
# ~/.bashrc: executed by bash for non-login shells.
#
###############################################################################


# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac


### HISTORY
###############################################################################

# Increase history size
HISTSIZE=10000
HISTFILESIZE=10000

# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth:erasedups

# Save and reload the history after each command finishes
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Clean up history file by removing all duplicates when opening new console
if [[ -f "$HISTFILE" ]]; then
    tac "$HISTFILE" | awk '!seen[$0]++' | tac > "${HISTFILE}.tmp" && mv -f "${HISTFILE}.tmp" "$HISTFILE"
fi

# Append to the history file, don't overwrite it
shopt -s histappend


### GENERAL
###############################################################################

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Enable tab-completion
complete -o default -o bashdefault op

# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Allows to cd into directory directly by typing directory name
shopt -s autocd

# Disable ctrl-s and ctrl-q (will freeze screen)
stty -ixon

# Make less more friendly for non-text input files, see lesspipe
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Display Git branch in PS1
git_branch() {
    git branch --show-current 2>/dev/null
}

# Set prompt
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;33m\] $(git_branch)\[\033[00m\]\$ '

# Set the title to user@host:dir
PS1="\[\e]0;\u@\h: \w\a\]$PS1"

# Colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add opencode
[ -d "$HOME/.opencode/bin" ] && export PATH="$HOME/.opencode/bin:$PATH"

# Disable python3.13 paste mode
# export PYTHON_BASIC_REPL=1


### ALIASES
###############################################################################

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias cp='cp -i'
alias mv='mv -i'

alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

if command -v eza &> /dev/null; then
    alias ls='eza'
    alias ll='ls -alF'
    alias la='ls -alF --icons'
    alias l.='ls -ld .*'
    alias tree='eza --tree'
else
    alias ls='ls --color=auto'
    alias ll='ls -alF'
    alias la='ls -ahlF'
    alias l.='ls -ld .*'
fi

alias op='xdg-open'
alias open='xdg-open'

alias p='python3'

# Date in format YYYY-MM-DD
alias da='date -I'

# White background theme for bat
alias bat='bat --theme=OneHalfLight'

# Add an "alert" alias for long running commands.
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Add Generic Makefile
alias addmake='cp ~/.config/nvim/templates/Makefile Makefile'


### VIM
###############################################################################

# Use nvim as default editor and for man pages
if command -v nvim >/dev/null; then
    alias vim='nvim'
    export VISUAL='nvim'
    export EDITOR='nvim'
    export MANPAGER='nvim +Man!'
fi

# vim mode
set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'

# Turn off caps if it is on
command -v xset >/dev/null && xset q >/dev/null 2>&1 | grep -q "Caps Lock:   on" && xdotool key Caps_Lock >/dev/null 2>&1

# Set caps to esc (ignore error if on remote system)
command -v setxkbmap >/dev/null && setxkbmap -option caps:escape 2>/dev/null

# Needed for git log
export PAGER=less


### SOURCE
###############################################################################

# Source local and private additions
[ -f ~/.bashrc_local ] && source ~/.bashrc_local

# Rust package manager
[ -f ~/.cargo/env ] && source ~/.cargo/env

# Fuzzy finder fzf
# This must be at the end, otherwise ** completion will not work.
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# uv
[ -f ~/.local/bin/env ] && source ~/.local/bin/env


### START
###############################################################################

# uv shell completions (only if installed)
if command -v uv &> /dev/null; then
    eval "$(uv generate-shell-completion bash)"
fi

if command -v uvx &> /dev/null; then
    eval "$(uvx --generate-shell-completion bash)"
fi

# Fast switching between tmux sessions
bind -x '"\C- ": tmux-sessionizer'

# Start screen
if command -v fastfetch &> /dev/null; then
  fastfetch
elif command -v neofetch &> /dev/null; then
  neofetch 2>/dev/null
fi
