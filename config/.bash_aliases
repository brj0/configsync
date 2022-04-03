# Personalized bashrc modifications that will be sourced by ubuntu's
# standard ~/.bashrc file

# aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias l.='la | grep "^\."'
alias cp='cp -i'
alias mv='mv -i'
alias p='python3.7'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias open='xdg-open'

# source local and private aliases
if [ -f ~/.bash_aliases_local ]; then
    . ~/.bash_aliases_local
fi

# vim mode
set -o vi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Set caps to esc
setxkbmap -option caps:escape

# Set environment variables
export PATH="$HOME/bin:$PATH"

# Disable ctrl-s and ctrl-q
stty -ixon

# Allows you to cd into dir directly by typing dir name
shopt -s autocd

# Start screen
neofetch 2>/dev/null

# Fuzzy finder fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
