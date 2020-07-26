#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Adds '/.local/bin' to $PATH
export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"
export PATH="$PATH:/home/eirik/build/of"
export PATH="$PATH:/home/eirik/.local/share/gem/ruby/2.7.0/bin"

# Default Programs
export TERMINAL="st"
export EDITOR="nvim"
export FILE="vifm"
export BROWSER="brave"
export READER="zathura"
export VIEWER="sxiv"
export STATUSBAR="slstatus"

# ~/ Clean-up
#export XAUTHORITY="XDG_RUNTIME_DIR/Xauthority"
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
export PASSWORD_STORE_DIR="$HOME/.local/share/password-store"
export NOTMUCH_CONFIG="$HOME/.config/notmuch-config"
export LESSHISTFILE="-"
export WGETRC="$HOME/.config/wget/wgetrc"
#export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
#export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export HISTFILE="$XDG_DATA_HOME/bash/history"
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export GEM_HOME="$XDG_DATA_HOME"/gem
export GEM_SPEC_CACHE="$XDG_CACHE_HOME"/gem

eval "$(keychain --dir /home/eirik/.config/.keychain --agents ssh,gpg --eval id_rsa aa-83)"

[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x dwm >dev/null && exec startx #"$XDG_CONFIG_HOME/X11/xinitrc"