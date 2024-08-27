# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

# Google Cloud SDK
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/tmees/google-cloud-sdk/path.zsh.inc' ]; then . '/home/tmees/google-cloud-sdk/path.zsh.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '/home/tmees/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/tmees/google-cloud-sdk/completion.zsh.inc'; fi

# Import aliases
source $HOME/.aliases

# jj to trigger normal mode
bindkey -M viins 'jj' vi-cmd-mode

# bind backspace to classic delete char (so can append and then delete)
bindkey -v '^?' backward-delete-char

# This function emits an OSC 1337 sequence to set a user var
# associated with the current terminal pane.
# It requires the `base64` utility to be available in the path.
# This function is included in the wezterm shell integration script, but
# is reproduced here for clarity
__wezterm_set_user_var() {
  if hash base64 2>/dev/null ; then
    if [[ -z "${TMUX}" ]] ; then
      printf "\033]1337;SetUserVar=%s=%s\007" "$1" `echo -n "$2" | base64`
    else
      # <https://github.com/tmux/tmux/wiki/FAQ#what-is-the-passthrough-escape-sequence-and-how-do-i-use-it>
      # Note that you ALSO need to add "set -g allow-passthrough on" to your tmux.conf
      printf "\033Ptmux;\033\033]1337;SetUserVar=%s=%s\007\033\\" "$1" `echo -n "$2" | base64`
    fi
  fi
}

# hooks
set_env_if_google_ops() {
    if [ "${PWD##*/}" = "google-ops" ] ; then
        local google_ops_env=$(gcloud config get project)
        case $google_ops_env in
            *ol-prod*)
                printf "\x1b]11;#660011\x1b\\"
                __wezterm_set_user_var "google-ops" "production"
                ;;
            *ol-stag*)
                printf "\x1b]11;#110066\x1b\\"
                __wezterm_set_user_var "google-ops" "staging"
                ;;
            *overleaf-ops*)
                printf "\x1b]11;#353500\x1b\\"
                __wezterm_set_user_var "google-ops" "ops"
                ;;
            *)
                printf "\x1b]11;#ee0000\x1b\\"
                echo "bad google-ops env value $google_ops_env"
                __wezterm_set_user_var "google-ops" "error"
                ;;
        esac
    elif [ "${OLDPWD##*/}" = "google-ops" ] ; then
        # reset
        printf "\x1b]111\x1b\\"
        __wezterm_set_user_var "google-ops" "no"
    fi
}
add-zsh-hook precmd set_env_if_google_ops

# To customize prompt, run `p10k configure` or edit ~/.zsh/.p10k.zsh.
[[ ! -f ~/.zsh/.p10k.zsh ]] || source ~/.zsh/.p10k.zsh
