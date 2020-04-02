#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Adds '/.local/bin' to $PATH
export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"
export PATH=$PATH:/home/eirik/build/of
export PATH=$PATH:/home/eirik/.gem/ruby/2.7.0/bin


# Default Programs
export TERMINAL="st"
export EDITOR="nvim"
export FILE="vifm"
export BROWSER="firefox"
export READER="zathura"
export VIEWER="sxiv"
export STATUSBAR='slstatus'

# ~/ Clean-up
export XAUTHORITY="XDG_RUNTIME_DIR/Xauthority"
#export
























eval "$(keychain --agents ssh,gpg --eval id_rsa aa-83)"

#[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x dwm >dev/null && exec startx
