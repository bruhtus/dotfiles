export ZDOTDIR="$HOME/.config/zsh"

#initialize XDG Base directory
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

export XINITRC="${XDG_CONFIG_HOME:-$HOME/.config}/usr/xinitrc"

export BROWSER=lynx
export EDITOR=nvim
export FZF_DEFAULT_OPTS="--height 20%"
export ZPLUG_HOME="$HOME/.config/zplug"

#dotbare
export DOTBARE_TREE="$HOME"
export DOTBARE_DIR="$HOME/.config"

#no less history
export LESSHISTFILE="-"

#coloring less
# Start blinking
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # green
# Start bold
export LESS_TERMCAP_md=$(tput bold; tput setaf 2) # green
# Start stand out
export LESS_TERMCAP_so=$(tput bold; tput setaf 3) # yellow
# End standout
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
# Start underline
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 1) # red
# End Underline
export LESS_TERMCAP_ue=$(tput sgr0)
# End bold, blinking, standout, underline
export LESS_TERMCAP_me=$(tput sgr0)

#CUDA
# export PATH="/opt/cuda/bin:$PATH"
# export CPATH="/opt/cuda/include:$CPATH"
# export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/opt/cuda/lib64:/opt/cuda/lib"
