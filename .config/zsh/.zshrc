# Luke's config for the Zoomer Shell

autoload -U colors && colors
PROMPT="%B[%F{11}%n%f%F{12}@%f%F{9}%m%f %F{13}%1~%f] %F{14}$%f%b "

autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit

# Include hidden files in autocomplete:
_comp_options+=(globdots)

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'

  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init

# Use beam shape cursor on startup.
echo -ne '\e[5 q'
# Use beam shape cursor for each new prompt.
preexec() { echo -ne '\e[5 q' ;}

# Use lf to switch directories and bind it to ctrl-o
vifmcd () {
    tmp="$(mktemp)"
    vifm -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

bindkey -s '^o' 'lfcd\n'  # zsh

#Aliases
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

# Man colour
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
