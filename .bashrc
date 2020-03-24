#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PS1="\[\e[36m\][\[\e[m\]\[\e[33m\]\u\[\e[m\]\[\e[34m\]@\[\e[m\]\[\e[31m\]\h\[\e[m\]\[\e[36m\] \[\e[m\]\[\e[35m\]\W\[\e[m\]\[\e[36m\]]\[\e[m\] \[\e[36m\]\\$\[\e[m\] "
export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
export LESS='-R '

set -o vi
bind C-l:clear-screen
shopt -s autocd

alias ls='ls --color=auto'
alias rm='rm -i'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias youtube-dl='youtube-dl --add-metadata'
alias srn='sudo reboot now'
alias hex='nvim -b'
alias hexedit='hexedit --color'

alias of='cd ~/build/of'
alias scripts='cd ~/.local/bin/scripts/'
alias arbeid='cd ~/Google_Drive/Arbeid/produksjoner'
alias skole='cd ~/Google_Drive/DDSKS/master/første_år/andre_semester'
alias bib='vim ~/documents/latex/bib/bibliografi.bib'
alias trash='cd ~/.local/share/vifm/Trash'

man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}
