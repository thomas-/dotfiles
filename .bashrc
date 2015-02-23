#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# package mgmt shortcuts
alias y='yaourt'
alias p='pacman'
alias wa='~/.w'
