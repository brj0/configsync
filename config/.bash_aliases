# Personalized bashrc modifications that will be sourced by Ubuntu's
# standard ~/.bashrc file

# Aliases
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

# For setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=10000

# Append to the history file, don't overwrite it
shopt -s histappend

# Don't put duplicate lines or lines starting with space in the history.
export HISTCONTROL=ignoreboth:erasedups

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Enables tab-completion
complete -o default -o bashdefault op

# White background theme for bat
alias bat='bat --theme=OneHalfLight'

# Source local and private aliases
if [ -f ~/.bash_aliases_local ]; then
    . ~/.bash_aliases_local
fi

# vim mode
set -o vi

# Use vim for man pages
export MANPAGER='/bin/bash -c "vim -MRn \
  -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod nolist norelativenumber nonu noma\" \
  -c \"normal L\" \
  -c \"nmap q :qa<CR>\" </dev/tty <(col -b)"'

# Colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Set caps to esc (ignore error if on remote system)
setxkbmap -option caps:escape 2>/dev/null

# Set environment variables
export PATH="$HOME/bin:$PATH"

# Disable ctrl-s and ctrl-q
stty -ixon

# Allows you to cd into dir directly by typing dir name
shopt -s autocd

# Start screen
neofetch 2>/dev/null

# Fuzzy finder fzf
# This must be at the end of bashrc, otherwise ** completion will not work.
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
