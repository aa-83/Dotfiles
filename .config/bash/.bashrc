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

alias ls='ls -hN --color=always --group-directories-first'
alias rm='rm -vI'
alias mv='mv -vi'
alias cp='cp -vi'
alias mkdir='mkdir -pv'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias yt='youtube-dl --add-metadata -i'
alias yta='yt -x -f bestaudio/best'
alias hex='nvim -b'
alias hexedit='hexedit --color'
alias bib='nvim ~/documents/latex/bib/bibliografi.bib'

alias db='cd ~/documents/build && pwd'
alias dof='cd ~/documents/build/of && pwd'
alias di='cd ~/documents/images && pwd'
alias diw='cd ~/documents/images/wallpapers && pwd'
alias div='cd ~/documents/images/video && pwd'
alias dmu='cd ~/documents/music && pwd'
alias dma='cd ~/documents/man && pwd'
alias dl='cd ~/documents/downloads && pwd'

alias dsa='cd ~/documents/syncdox/arbeid/produksjoner && pwd'
alias dsd='cd ~/documents/syncdox/universitet/ddsks/master/første_år/andre_semester && pwd'
alias art='cd ~/documents/syncdox/universitet/ddsks/master/artistic_research && pwd'

alias conf='cd ~/.config && pwd'
alias lb='cd ~/.local/bin && pwd'
alias lbs='cd ~/.local/bin/scripts && pwd'
alias lsh='cd ~/.local/share && pwd'
alias vt='cd ~/.local/share/vifm/Trash && pwd'

alias srn='sudo reboot now'
alias sdn='sudo shutdown now'

alias abook='abook -C "$XDG_CONFIG_HOME"/abook/abookrc --datafile "$XDG_DATA_HOME"/abook/addressbook'
alias tmux='tmux -f "$XDG_CONFIG_HOME"/tmux/tmux.conf'
alias calcurse='calcurse -D ~/.config/calcurse/'

man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}
