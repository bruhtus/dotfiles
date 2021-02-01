# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

bindkey -v
setopt autocd

#history
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.cache/zsh/history

#dotbare
export DOTBARE_DIR="$HOME/.config"
export DOTBARE_TREE="$HOME"

#zplug
source $HOME/.zplug/init.zsh
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "plugins/git", from:oh-my-zsh
zplug "lib/directories", from:oh-my-zsh
zplug "lib/completion", from:oh-my-zsh
zplug "lib/grep", from:oh-my-zsh
zplug "lib/history", from:oh-my-zsh
zplug "kazhala/dotbare"
zplug "romkatv/powerlevel10k", as:theme, depth:1
#install plugins if there're plugins that haven't been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load

#install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"

#CUDA
export PATH="/opt/cuda/bin:$PATH"
export CPATH="/opt/cuda/include:$CPATH"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/opt/cuda/lib64:/opt/cuda/lib"

#basic auto-tab complete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit

#display git status
function qwe(){~/.i3/git-status-checker | less}

#unfaedah alias
alias asd='googler -n 4'
#alias asd='ddgr -n 4'
alias zxc='youtube-viewer -C --custom-layout --fixed-width --resolution=480p' #poor internet
alias reload='source ~/.zshrc'
alias zshalias='egrep "^alias|^function" ~/.zshrc | less'
alias ka='killall'
alias mp='markdown_previewer'
alias wttr='curl wttr.in\?%tpFQn1m'
alias translate='gawk -f <(curl -Ls git.io/translate) -- -shell'
alias ipa='curl ifconfig.co'
alias mm='morc_menu'
alias bt='bpytop'
alias rs='rsync -ahP'
alias cm='cd /run/media'
alias v='vim'
alias rr='ranger'

#never gonna give you up
alias saveme='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'

#find directory (cd to it) and files (open in vim)
#alias f='fzf | tr -d "\n" | xsel -ib' #tr truncated from the \n char at the end of the line
function sd(){cd "$(du ~ | awk '{print $2}' | fzf --height 20%)"} #cd to any directories in home directory from any directories
function cs(){find ~ -type f | egrep -v '*\.jpg|*\.jpeg|*\.png|*\.epub|*\.mobi|*\.pdf|*\.mp4|*\.svg|miniconda3/|gems/|\.local/' | fzf --height 20% | xargs -o -r vim} #search and open file on home directory in vim directly, -o so that it doesn't break my terminal, -r for if doesn't have entry then it exit

#convert groff to pdf with table of contents
function pf(){pdfroff -mspdf -t $1 > $2}
#convert groff to pdf, default command
function gms(){groff -ms -t -T pdf $1 > $2}

#mounting and unmounting from CLI
function dm(){udisksctl mount -b /dev/$1}
function dum(){udisksctl unmount -b /dev/$1}

#verbosity
alias cp='cp -iv' #confirm before overwriting
alias mv='mv -iv' #confirm before overwriting
alias rm='rm -v'

#dotbare alias
alias dba='dotbare add'
alias dbc='dotbare commit -m'
alias dbp='dotbare push'
alias dbd='dotbare diff'

#change ls to exa
alias ls='exa -l --links -t=changed --git --group --color=always --group-directories-first --sort=ext'
alias ll='exa -l --inode --header --blocks --links -t=changed --time-style=long-iso --git --group --color=always --group-directories-first --sort=ext'
alias l.='exa -al -t=changed --git --group --color=always --group-directories-first | egrep "^\."'
#alias lt='exa -l --tree --level=2 --links -t=changed --git --group --color=always --group-directories-first --sort=ext'

#open exa tree in less
function lt(){
    exa -al --tree --level=2 --links -t=changed --git --group --color=always --group-directories-first --sort=ext $1 | less -F
}

#grep, less, and count
alias -g G='| grep'
alias -g L='| less'
alias -g C='| wc -l'

#like pastebin but on terminal directly (using vim readonly mode for easy copy-paste)
function termbin(){vim -R <($@ | nc termbin.com 9999)}

#pipe error to a file
alias -g E='2> error.nganu'

#conda alias
alias cenv='conda env list'
alias cac='conda activate'
alias cde='conda deactivate'
function cce(){conda create -n $1 python=$2}

#python alias
function p(){python $@ | less -F}
function pl(){python $@ | less}
function pc(){python -c $1}
function pv(){vim -R <(python $@)}

#pacman and yay alias
alias pacsyu='sudo pacman -Syu'
alias yalord='sudo pacman'
alias pacss='pacman -Ss'
alias yays='yay -S'
alias yayss='yay -Ss'
alias yaysua='yay -Sua'
alias yayq='yay -Qua'

#cpu and memory alias
alias cpu='ps axch -o cmd:15,%cpu --sort=-%cpu | head'
alias mem='ps axch -o cmd:15,%mem --sort=-%mem | head'

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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/bruhtus/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/bruhtus/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/bruhtus/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/bruhtus/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
