bindkey -v
setopt autocd
setopt auto_pushd
# setopt pushd_minus
setopt pushd_silent
setopt pushd_ignore_dups
setopt extended_history
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_verify
setopt share_history
unsetopt menu_complete
setopt always_to_end

#history
HISTSIZE=10000000
SAVEHIST=1000000
# create .cache/zsh directory if it doesn't exists
[ -d "${XDG_DATA_HOME:-$HOME/.local/share}/zsh" ] && HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/history" || \
  mkdir "${XDG_DATA_HOME:-$HOME/.local/share}/zsh" && HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/history"

#load aliases if exist
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliasrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/gitrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/gitrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/pyv" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/pyv"

# case insensitive completion
# ref: https://superuser.com/a/1092328
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

#basic auto-tab complete
zstyle ':completion:*' menu select
autoload -U compinit
zmodload zsh/complist
compinit -d ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/zcompdump-$ZSH_VERSION

# add zsh plugin
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/minzsh" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/minzsh" && \
  mzadd kazhala/dotbare && \
  mzadd zsh-users/zsh-syntax-highlighting && \
  mzadd zsh-users/zsh-history-substring-search && \
  # mzadd zdharma/fast-syntax-highlighting && \

#vim keys to tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# zsh-history-substring-search keybindings
bindkey '^K' history-substring-search-up
bindkey '^J' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

#figlet -f slant bruhtus
#pfetch

#Edit line in vim with ctrl-f:
autoload edit-command-line; zle -N edit-command-line
bindkey '^f' edit-command-line

function set_win_title(){
  # echo -ne "\033]0; $(basename "$PWD") \007"
  print -Pn "\e]0;%~\a"
}

# check `man zshmisc`
precmd_functions+=(set_win_title)

eval "$(starship init zsh)"
