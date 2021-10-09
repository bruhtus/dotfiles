# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

bindkey -v
setopt autocd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus
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
[ -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh" ] && HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history" || \
  mkdir "${XDG_CACHE_HOME:-$HOME/.cache}/zsh" && HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"

#load aliases if exist
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliasrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/gitrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/gitrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/pyv" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/pyv"

#basic auto-tab complete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -d ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/zcompdump-$ZSH_VERSION

# add zsh plugin
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/minzsh" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/minzsh" && \
  mzadd kazhala/dotbare && \
  mzadd romkatv/powerlevel10k

#vim keys to tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

#figlet -f slant bruhtus
#pfetch

#make sure zsh-syntax-highlight installed
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

#Edit line in vim with ctrl-x:
autoload edit-command-line; zle -N edit-command-line
bindkey '^x' edit-command-line

# case insensitive (all), partial-word and substring completion
if [[ "$CASE_SENSITIVE" = true ]]; then
  zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*'
else
  if [[ "$HYPHEN_INSENSITIVE" = true ]]; then
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
  else
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
  fi
fi
unset CASE_SENSITIVE HYPHEN_INSENSITIVE

function set_win_title(){
  # echo -ne "\033]0; $(basename "$PWD") \007"
  print -Pn "\e]0;%~\a"
}

precmd_functions+=(set_win_title)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
