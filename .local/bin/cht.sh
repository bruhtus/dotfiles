#!/bin/sh
# Best served with tmux new window

languages="golang vim vimscript typescript javascript react react-native nodejs"
core_utils="xargs find mv sed awk ripgrep"

selected=$(echo "$languages" "$core_utils" | tr ' ' '\n' | fzf)

read -p "Enter query: " query

# Ref: https://www.baeldung.com/linux/string-contains-substring
# Ref: https://stackoverflow.com/a/19661320
[ -z "${languages##*$selected*}" ] && \
  (curl -fL --no-progress-meter cht.sh/$selected/"${query// /+}" | less -r) || \
  (curl -fL --no-progress-meter cht.sh/$selected~$query | less -r)
