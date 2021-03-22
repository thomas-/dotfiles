#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
eval "$(rbenv init -)"

# Import aliases
source $HOME/.aliases

# jj to trigger normal mode
bindkey -M viins 'jj' vi-cmd-mode

# bind backspace to classic delete char (so can append and then delete)
bindkey -v '^?' backward-delete-char
