#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# startx automatically on tty1
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
