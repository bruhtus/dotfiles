# according to this comment:
# https://unix.stackexchange.com/questions/71253/what-should-shouldnt-go-in-zshenv-zshrc-zlogin-zprofile-zlogout#comment400105_71258
# should be careful when set env variable in .zshenv
# because other files that executed after this file can override the $PATH in this file.
# so, using .zprofile instead of .zshenv to set env variable.
# to apply the updates, use `exec zsh --login`.

# zsh
export ZDOTDIR="$HOME/.config/zsh"

# initialize XDG Base Directory
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

# xinit
export XINITRC="${XDG_CONFIG_HOME:-$HOME/.config}/x11/xinitrc"

# path
## executable script
export PATH="$PATH:$HOME/.local/bin"
## npm global
export PATH="$PATH:${XDG_DATA_HOME:-$HOME/.local/share}/npm/bin"
## ruby gems
export PATH="$PATH:${XDG_DATA_HOME:-$HOME/.local/share}/gem/bin"

# non xdg-open web browser
export BROWSER=lynx

# editor
export EDITOR=vim

# fzf
export FZF_DEFAULT_OPTS="--height 20% --bind 'ctrl-/:toggle-preview,ctrl-n:preview-down,ctrl-p:preview-up' --preview='head -$LINES {}' --preview-window=wrap,hidden"

# ripgrep
export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME:-$HOME/.config}/ripgrep/ripgreprc"

# dotbare
export DOTBARE_TREE="$HOME"
export DOTBARE_DIR="$HOME/.config"

# terminal emulator
export TERMINAL=alacritty

# qt application
export QT_QPA_PLATFORMTHEME="qt5ct"

# wget
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"

# gtk2
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc"

# npm config
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/npm/npmrc"

# parallel
export PARALLEL_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/parallel"

# go
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"

# bash
export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/bash/history"

# visidata
export VD_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/visidata"

# install ruby gems to ~/.local/share/gem
export GEM_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/gem"
export GEM_SPEC_CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/gem"
# make sure to remove gem: --user-install from /etc/gemrc

# bundle
export BUNDLE_USER_CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/bundle"
export BUNDLE_USER_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/bundle"
export BUNDLE_USER_PLUGIN="${XDG_DATA_HOME:-$HOME/.local/share}/bundle"

# rust cargo
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"

# zoom
export SSB_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zoom"

# no less history
export LESSHISTFILE="-"

# coloring less
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

# change ls color
# ls color list: https://askubuntu.com/a/466203
# ls default colors meaning: https://askubuntu.com/a/884513
# declare -A descriptions=(
#     [bd]="block device"
#     [ca]="file with capability"
#     [cd]="character device"
#     [di]="directory"
#     [do]="door"
#     [ex]="executable file"
#     [fi]="regular file"
#     [ln]="symbolic link"
#     [mh]="multi-hardlink"
#     [mi]="missing file"
#     [no]="normal non-filename text"
#     [or]="orphan symlink"
#     [ow]="other-writable directory"
#     [pi]="named pipe, AKA FIFO"
#     [rs]="reset to no color"
#     [sg]="set-group-ID"
#     [so]="socket"
#     [st]="sticky directory"
#     [su]="set-user-ID"
#     [tw]="sticky and other-writable directory"
# )
export LS_COLORS="ow=1;34;40"

# cuda
# export PATH="/opt/cuda/bin:$PATH"
# export CPATH="/opt/cuda/include:$CPATH"
# export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/opt/cuda/lib64:/opt/cuda/lib"

# task config and data
# export TASKRC="${XDG_CONFIG_HOME:-$HOME/.config}/task/taskrc"
# export TASKDATA="${XDG_DATA_HOME:-$HOME/.local/share}/task"