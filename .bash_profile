#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export TERMINAL="st"
export EDITOR="nvim"
export FILE="vifm"
export BROWSER="firefox"
export READER="zathura"
export VIEWER="sxiv"
export PATH="$(du $HOME/.local/bin/scripts | cut -f2 | tr '\n' ':')$PATH"
export PG_OF_PATH="$(du $HOME/build/of | cut -f2 | tr '\n' ':')$PATH"
export GPG_AGENT_INFO=""
eval "$(keychain --agents ssh,gpg --eval id_rsa aa-83)"

PATH=$PATH:/home/eirik/build/of
PATH=$PATH:/home/eirik/.gem/ruby/2.7.0/bin
PATH=$PATH:/home/eirik/.local/bin/scripts

[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x dwm >dev/null && exec startx
