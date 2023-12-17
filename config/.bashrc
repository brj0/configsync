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
tac "$HISTFILE" | awk '!x[$0]++' > ~/.bash_history_reverse &&
    tac ~/.bash_history_reverse > "$HISTFILE"
rm -f ~/.bash_history_reverse

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

# Use colors
export TERM="xterm-256color"

# Set prompt
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# Set the title to user@host:dir
PS1="\[\e]0;\u@\h: \w\a\]$PS1"

# Colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add ~/bin to PATH
[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"


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

alias l.='ls -d .* --color=auto'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'

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
alias addmake='cp ~/.vim/templates/Makefile Makefile'


### VIM
###############################################################################

# vim as standard editor
export VISUAL=vim
export EDITOR="$VISUAL"

# vim mode
set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'

# Set caps to esc (ignore error if on remote system)
setxkbmap -option caps:escape 2>/dev/null

# Use vim for man pages
export MANPAGER='/bin/bash -c "vim -MRn \
    -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod nolist norelativenumber nonu noma\" \
    -c \"normal L\" \
    -c \"nmap q :qa<CR>\" </dev/tty <(col -b)"'


### SOURCE
###############################################################################

# Source local and private additions
[ -f ~/.bashrc_local ] && source ~/.bashrc_local

# Rust package manager
[ -f ~/.cargo/env ] && source ~/.cargo/env

# Fuzzy finder fzf
# This must be at the end, otherwise ** completion will not work.
[ -f ~/.fzf.bash ] && source ~/.fzf.bash


### START
###############################################################################

# Fast switching between tmux sessions
bind -x '"\C- ": tmux-sessionizer'

# Start screen
neofetch 2>/dev/null
