
export EDITOR=vim
# jj to trigger normal mode
bindkey -M viins 'jj' vi-cmd-mode
# up/down searching using beginning of current line if applicable
autoload up-line-or-beginning-search
autoload down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search
# bind backspace to classic delete char (so can append and then delete)
bindkey -v '^?' backward-delete-char
# shift-tab to reverse cycle tab completion
bindkey '^[[Z' reverse-menu-complete

fossil_get_current_hash() {
    fossil status | grep checkout | awk '/checkout:/{printf "["substr($2,0,10)"]"}' | pbcopy
}

# fossil aliases
alias fd='fossil diff --tk'
alias f='fossil'
alias fz=fossil_get_current_hash

# useful apps
alias v='vim'
alias hp='haplo-plugin'

# locations
alias dev='cd ~/Develop'

autoload -U zutil
autoload -U compinit
autoload -U complist
compinit -i

setopt AUTO_CD
setopt NO_BEEP
setopt EXTENDED_GLOB

HISTFILE=~/.zhistory
HISTSIZE=SAVEHIST=10000
setopt incappendhistory
setopt sharehistory
setopt extendedhistory

setopt interactivecomments

zstyle ':completion:*' special-dirs true

