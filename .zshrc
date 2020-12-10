# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/bruhtus/.oh-my-zsh"
export DOTBARE_DIR="$HOME/.config"
export DOTBARE_TREE="$HOME"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

#(cat ~/.cache/wal/sequences &)
#cat ~/.cache/wal/sequences
#source ~/.cache/wal/colors-tty.sh

#(cat ~/.config/sequences &)
#cat ~/.config/sequences
#source ~/.config/colors-tty.sh

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git dotbare)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"
export PATH="$HOME/.emacs.d/bin:$PATH"

#install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"

#CUDA
export PATH="/opt/cuda/bin:$PATH"
export CPATH="/opt/cuda/include:$CPATH"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/opt/cuda/lib64:/opt/cuda/lib"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#alias asd='vim -R <(python ~/git-status-checker.py)' #using vim
#alias qwe='python ~/git-status-checker.py | less' #using less

#display git status
function qwe(){ #directly into zshrc
    python -c "
import os

os.chdir(os.path.expanduser('~/all_git'))
dir_list = [dirname for dirname in os.listdir(os.getcwd()) if os.path.isdir(dirname) == True]

for dirname in dir_list:
    os.chdir(dirname)
    os.system('pwd')

    if os.path.exists('.gitmodules') == True:
        os.system('git status -s')
        os.system('git submodule foreach git status -s')
    else:
        os.system('git status -s')

    os.chdir('../')

os.chdir('../')
os.system('pwd')
os.system('dotbare status -s')" | less -F
}

#unfaedah alias
alias asd='googler -n 4'
alias zxc='youtube-viewer -C --custom-layout --fixed-width --resolution=480p' #poor internet
alias reload='source ~/.zshrc'
alias zshalias='grep "^alias" ~/.zshrc | less'
alias v='dirs -v'

#dotbare alias
alias dba='dotbare add'
alias dbc='dotbare commit -m'
alias dbp='dotbare push'
alias dbd='dotbare diff ~'

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

#pipe error to a file
alias -g E='2> error'

#conda alias
alias cenv='conda env list'
alias cac='conda activate'
alias cde='conda deactivate'

#python alias
function p(){python $@ | less -F}
function pl(){python $@ | less}
function pc(){python -c $1}

#pacman and yay alias
alias pacsyu='sudo pacman -Syu'
alias yalord='sudo pacman'
alias pacss='pacman -Ss'
alias yaysua='sudo yay -Sua'
alias yays='yay -S'
alias yayss='yay -Ss'

#vim keys to tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
#alias config='/usr/bin/git --git-dir=/home/bruhtus/.config/ --work-tree=/home/bruhtus'
bindkey -v

#figlet -f slant bruhtus
pfetch

#make sure zsh-syntax-highlight installed
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# Edit line in vim with ctrl-x:
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

