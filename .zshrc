
export PATH=$PATH:/usr/local/bin:~/bin/jruby/bin

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

fossil_merge_commit() {
    current_branch=$(fossil status|awk '/tags/{print $2; exit;}')
    new_branch=$1
    fossil update
    if fossil checkout $new_branch >/dev/null
    then
        fossil merge $current_branch
        fossil commit -m "merge $current_branch into $new_branch"
        fossil checkout $current_branch >/dev/null
    else
        echo "no branch named $new_branch"
    fi
}

# fossil aliases
alias f='fossil'
alias fd='fossil diff --tk'
alias fcm='fossil commit -m'
alias fm=fossil_merge_commit
alias fz=fossil_get_current_hash

# useful apps
alias l='ls'
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

