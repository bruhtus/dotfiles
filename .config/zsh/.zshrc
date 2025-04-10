# ref: man zshzle
bindkey -e

# ref:
# https://zsh.sourceforge.io/Doc/Release/Options.html
# https://unix.stackexchange.com/a/670027
# history options explanation: https://zsh.sourceforge.io/Guide/zshguide02.html#l18
# currently unset options: `unsetopt`
setopt auto_pushd
setopt pushd_silent
setopt pushd_ignore_dups
setopt hist_find_no_dups
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_save_no_dups
setopt hist_no_store
setopt hist_no_functions
setopt hist_reduce_blanks
# setopt inc_append_history
setopt always_to_end
unsetopt menu_complete

_set_win_title() {
  # echo -ne "\033]0; $(basename "$PWD") \007"
  print -Pn "\e]0;%~\a"
}

# check `man zshmisc`
precmd_functions+=(_set_win_title)

preexec() {
  fc -AI
  print -n "\e]133;C\e\\"
}

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

# ref: man zshparam
ZLE_REMOVE_SUFFIX_CHARS=$' \t\n;'

# history
HISTSIZE=100000
SAVEHIST=100000
HISTORY_IGNORE='(cd|cd ..|clear|less *|ls|ls *|command -v *|which *|which-command *|cp *|mv *|rm *|cal|cal *|nmtui|bash|dash|dash -E|[1-9]|nnn|n|sx|d|qwe|sd|da|ds|sc|cs|v|zxc|sdfa *|sdfc|sdfc *|sdfd|sdfd *|sdfs|sdfp|sdfpl|sdfl|cpu|mem|t|ta *|kj|nmls|nmco *|nmdc *|gss|gd|gaf|gc|gc -a|gca|gca *|gp|gpf|ggp|gbd|nj|gch -|gchf|gco|gct|ggl|ggl *|gl|gmt|gurm|gres|gfp|gwl|gwa|gwr|gst|gstu|gstp|gstf|gstl|gcd|gcb *|reload)'
# create .local/state directory if it doesn't exist
# parameter expansion: https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html
# XDG_STATE_HOME explanation:
# https://wiki.debian.org/XDGBaseDirectorySpecification#state
if [ -d "${XDG_STATE_HOME:-$HOME/.local/state}" ]; then
  HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh_history"
else
  mkdir -p "${XDG_STATE_HOME:-$HOME/.local/state}" || \
    echo "Error create ${XDG_STATE_HOME:-$HOME/.local/state} with exit code $?"
  HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh_history"
fi

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
zstyle ':completion:*' menu yes=2 select interactive
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

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/sdfm" ] && \
  . "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/sdfm"

compdef _files sdfa
compdef _files sdfd

# add zsh plugin
# [ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/minzsh" ] && . "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/minzsh" && \
#   {
#     # mzadd zsh-users/zsh-history-substring-search
#     # mzadd zsh-users/zsh-syntax-highlighting
#     # mzadd zdharma/fast-syntax-highlighting
#   }

# ctrl-i to trigger interactive mode.
bindkey -M menuselect '^I' interactive

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

# bindkey -M vicmd 'k' up-line
# bindkey -M vicmd 'j' down-line

# ref edit-command-line: `man zshcontrib`
# ref autoload: `man zshbuiltins`
# ref zle: `man zshzle`
# edit line in vim with ctrl-x ctrl-e (similar on bash)
autoload -Uz edit-command-line; zle -N edit-command-line
bindkey '^X^E' edit-command-line

# delete word until non-alphanumeric character
bindkey '^[^H' vi-backward-kill-word

# delete from beginning of the line to the cursor position
bindkey '^U' backward-kill-line

# expand word from left of cursor instead of under the cursor
bindkey '^I' expand-or-complete-prefix

# readline-like keybinding
# ref: https://stackoverflow.com/a/19344422
rl-kill-word() {
  WORDCHARS='' zle kill-word
}
zle -N rl-kill-word
bindkey '^[d' rl-kill-word

rl-backward-word() {
  WORDCHARS='' zle backward-word
}
zle -N rl-backward-word
bindkey '^[b' rl-backward-word

rl-forward-word() {
  WORDCHARS='' zle forward-word
}
zle -N rl-forward-word
bindkey '^[f' rl-forward-word

rl-transpose-words() {
  WORDCHARS='' zle transpose-words
}
zle -N rl-transpose-words
bindkey '^[t' rl-transpose-words

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

[ -f ${ZDOTDIR:-$HOME/.config/zsh}/prompt ] && . ${ZDOTDIR:-$HOME/.config/zsh}/prompt
