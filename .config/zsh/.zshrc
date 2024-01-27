# ref: man zshzle
bindkey -e

# ref:
# https://zsh.sourceforge.io/Doc/Release/Options.html
# https://unix.stackexchange.com/a/670027
setopt autocd
setopt auto_pushd
# setopt pushd_minus
setopt pushd_silent
setopt pushd_ignore_dups
# setopt extended_history
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_save_no_dups
setopt hist_save_by_copy
setopt hist_verify
setopt share_history
setopt append_history
# setopt inc_append_history
unsetopt menu_complete
setopt always_to_end
# setopt no_flow_control
# unsetopt complete_aliases

#(hopefully) remove maximum nested function level reached; increase FUNCNEST?
#still not sure what's going on
# FUNCNEST=1500

# every time any command we run that takes longer than the value we set it to in seconds,
# zsh will print usage statistics afterwards as if you had run the command prefixed with time.
# ref: man zshparam
REPORTTIME=10

# ref:
# https://unix.stackexchange.com/a/562651
# https://www.baeldung.com/linux/time-command
# https://en.wikipedia.org/wiki/User-mode_Linux
# https://wiki.archlinux.org/title/User-mode_Linux
TIMEFMT='%J  %*U user %*S system %P cpu %*E total'

#history
HISTSIZE=100000000
SAVEHIST=10000000
# create .local/state directory if it doesn't exist
# parameter expansion: https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html
# XDG_STATE_HOME explanation:
# https://wiki.debian.org/XDGBaseDirectorySpecification#state
[ -d "${XDG_STATE_HOME:-$HOME/.local/state}" ] && HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh_history" || \
  mkdir "${XDG_STATE_HOME:-$HOME/.local/state}" && HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh_history"

# load aliases if exist
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliasrc" ] && . "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliasrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/gitrc" ] && . "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/gitrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/pyv" ] && . "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/pyv"

# basic auto-tab complete
zmodload zsh/complist
zmodload zsh/computil

# ref:
# - man zshcompsys
# - check `compinstall` command
# - https://superuser.com/a/1092328 (case insensitive completion)
zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' group-name ''
zstyle ':completion:*' file-sort name
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu yes select interactive
zstyle ':completion:*' select-prompt '%l'
zstyle ':completion:*' use-compctl true

# format: ':completion:<function>:<completer>:<command>:<argument>:<tag>'
zstyle ':completion:*:*:ls:*:*' list-dirs-first true

zcompdump="${XDG_STATE_HOME:-$HOME/.local/state}/zcompdump"
autoload -Uz compinit
compinit -d $zcompdump
_comp_options+=(globdots)

# ref:
# - man zshbuiltins
# - https://github.com/romkatv/zsh-bench/blob/3b4896c4840c64bea8e79b8392a93dfdc5a0a096/configs/diy%2B%2B/skel/.zshrc#L32
[ $zcompdump.zwc -nt $zcompdump ] || zcompile -R $zcompdump
unset -v zcompdump

# add zsh plugin
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/minzsh" ] && . "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/minzsh" && \
  {
    mzadd kazhala/dotbare
    # mzadd zsh-users/zsh-history-substring-search
    # mzadd zsh-users/zsh-syntax-highlighting
    # mzadd zdharma/fast-syntax-highlighting
  }

# vim keys to tab complete menu
# bindkey -M menuselect 'h' vi-backward-char
# bindkey -M menuselect 'j' vi-down-line-or-history
# bindkey -M menuselect 'k' vi-up-line-or-history
# bindkey -M menuselect 'l' vi-forward-char

# zsh-history-substring-search keybindings
# bindkey '^[[A' history-substring-search-up
# bindkey '^[[B' history-substring-search-down
# bindkey -M vicmd 'k' history-substring-search-up
# bindkey -M vicmd 'j' history-substring-search-down

bindkey -M vicmd 'k' up-line
bindkey -M vicmd 'j' down-line

#figlet -f slant bruhtus
#pfetch

# ref edit-command-line: `man zshcontrib`
# ref autoload: `man zshbuiltins`
# ref zle: `man zshzle`
# edit line in vim with ctrl-x ctrl-e (similar on bash)
autoload -Uz edit-command-line; zle -N edit-command-line
bindkey '^X^E' edit-command-line

# delete word until non-alphanumeric character
bindkey '^[^H' vi-backward-kill-word

# expand word from left of cursor instead of under the cursor
bindkey '^I' expand-or-complete-prefix

# ref: https://stackoverflow.com/a/23134765
# bindkey '^A' beginning-of-line
# bindkey '^E' end-of-line
# bindkey '^B' backward-char
# bindkey '^F' forward-char
# bindkey '^K' kill-line
# bindkey '^X^F' vi-find-next-char
# bindkey '^X^B' vi-find-prev-char
# bindkey '^X;' vi-repeat-find
# bindkey '^X,' vi-rev-repeat-find

# bindkey '^R' history-incremental-search-backward
# bindkey '^J' history-incremental-search-forward

set_win_title(){
  # echo -ne "\033]0; $(basename "$PWD") \007"
  print -Pn "\e]0;%~\a"
}

# check `man zshmisc`
precmd_functions+=(set_win_title)

[ -f ${ZDOTDIR:-$HOME/.config/zsh}/prompt ] && . ${ZDOTDIR:-$HOME/.config/zsh}/prompt
