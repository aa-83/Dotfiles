autoload -Uz colors && colors
autoload -Uz promptinit

# Left prompt
PROMPT='%B[%b%F{#f58700}%n%f%B%F{#0000ff}@%f%b%B%F{#cc0000}%m%f%b %F{#b11cb1}%1~%f%B]%b %B%F{#0abdb6}$%f%b '

# Right prompt
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' actionformats \
	'(%F{#F09000}%s%f)%F{#FF00FF}/%f[%F{#0000F0}%b|%a%f] %B%F{#0f0f0f}%u%f %F{#f0f0f0}%c%f'
zstyle ':vcs_info:git:*' formats \
	'(%F{#F09000}%s%f)%F{#FF00FF}/%f[%F{#0000F0}%b%f] %B%F{#0f0f0f}%u%f %F{#f0f0f0}%c%f'
zstyle ':vcs_info:*' enable git
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
RPROMPT='%B$vcs_info_msg_0_%b %F{#00F000}%*%f %F{#F000F0}%D%f [%B%F{#F00000}%?%f%b]'
promptinit

autoload -Uz compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# Search for new executables automagically
zstyle ':completion:*' rehash true
zmodload zsh/complist
# Include hidden files in autocomplete:
_comp_options+=(globdots)
compinit

setopt always_to_end
setopt auto_cd
setopt auto_list
setopt auto_pushd
setopt auto_param_slash
setopt auto_param_keys
#setopt bang_hist
setopt clobber
setopt complete_aliases
setopt correct_all
setopt complete_in_word
#setopt extended_glob
setopt globdots
#setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt interactive_comments
setopt list_rows_first
setopt long_list_jobs
setopt no_case_glob
setopt no_nomatch
setopt nohup
setopt notify
setopt pushd_ignore_dups
setopt pushd_to_home

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc"

# History in cache directory:
HISTSIZE=2000000
SAVEHIST=2000000
HISTFILE=~/.cache/zsh/history

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
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

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

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


# Help-function
autoload -Uz run-help
unalias run-help
alias help=run-help
autoload -Uz run-help-git run-help-ip run-help-openssl run-help-p4 run-help-sudo run-help-svk run-help-svn

# Fuzzy plugin
source /usr/share/fzf/key-bindings.zsh 2>/dev/null
source /usr/share/fzf/completion.zsh 2>/dev/null

#fzf

export FZF_DEFAULT_COMMAND="find -type d,f 2>/dev/null"
export FZF_DEFAULT_OPTS=" --border=sharp --layout=reverse --info=inline \
--height=50% --multi --preview-window=:hidden --preview '([[ -f {} ]] && cat {}) \
|| ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200' \
--color='hl:148,hl+:154,pointer:032,marker:010,bg+:237,gutter:008' --prompt='∼ ' \
--pointer='>' --marker='*' --bind '?:toggle-preview' --bind 'ctrl-a:select-all' \
--bind 'ctrl-y:execute-silent(echo {+} | xclip)' --bind 'ctrl-o:execute(nvim {1} \
> /dev/tty)+abort'"
export FZF_CTRL_T_COMMAND="find -type f 2>/dev/null"
export FZF_CTRL_T_OPTS="--select-1 --exit-0"
export FZF_ALT_C_COMMAND="find -type d 2>/dev/null"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

# Search for missing packages
source /usr/share/doc/pkgfile/command-not-found.zsh 2>/dev/null

# Load zsh-autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ea00d9"
# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# Mac placements
#source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ea00d9"
#source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
