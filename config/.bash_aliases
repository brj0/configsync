# Personalized bashrc modifications that will be sourced by ubuntu's
# standard ~/.bashrc file

# aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias cp='cp -i'
alias dir='dir --color=auto'
alias l.=' ls -d .* --color=auto'
alias mv='mv -i'
alias op='xdg-open'
alias open='xdg-open'
alias p='python3'
alias vdir='vdir --color=auto'

# White backgound theme for bat
alias bat='bat --theme=OneHalfLight'

# source local and private aliases
if [ -f ~/.bash_aliases_local ]; then
    . ~/.bash_aliases_local
fi

# vim mode
set -o vi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Colos for man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;44;33m'
export LESS_TERMCAP_so=$'\e[00;103;30m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

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
