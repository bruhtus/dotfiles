# Personal Dotfiles

![setup-screenshot](https://raw.githubusercontent.com/wiki/bruhtus/dotfiles/arch-linux-setup-sep-2023.png)

This repo is to backup my linux configuration so that I don't need to
re-configure every new installation.
I use [dotbare](https://github.com/kazhala/dotbare) to manage my dotfiles.
Below is the simplified version to setup dotbare.

## Initialize dotbare to backup dotfiles
```sh
dotbare finit
```

#### Example command
```sh
dotbare status
dotbare add .zshrc
dotbare commit -m 'Add zshrc'
dotbare push origin master
```

## Restore dotfiles in new system
> Note to myself: don't forget to make the script executable by doing
> `chmod +x <filename>`

> To enable updates-notifier, use
> `systemctl --user enable --now updates-notifier.timer`

Install zsh first, and then do the instruction below:

```sh
wget https://raw.githubusercontent.com/bruhtus/dotfiles/master/.config/zsh/minzsh
. ./minzsh
mzadd kazhala/dotbare
export DOTBARE_DIR="$HOME/.local/state/dotbare"
dotbare finit -u git@github.com:bruhtus/dotfiles.git
```

<details>
<summary><strong>Some details about my setup</strong></summary>

Category             | Name
---                  | ---
Operating system     | [Arch linux](https://archlinux.org/)
Window manager       | [i3](https://github.com/i3/i3)
Text editor          | [Vim](https://github.com/vim/vim)<br> [Neovim](https://github.com/neovim/neovim) (no longer using)
Terminal emulator    | [Alacritty](https://github.com/alacritty/alacritty)
Terminal multiplexer | [Tmux](https://github.com/tmux/tmux)
Shell                | [Zsh](https://zsh.sourceforge.io/Doc/Release/index.html) (interactive)<br> [Bash](https://www.gnu.org/software/bash/)
Shell prompt         | [Custom zsh prompt](https://github.com/bruhtus/dotfiles/blob/master/.config/zsh/prompt)<br> [Starship](https://starship.rs/) (no longer using)<br> [Powerlevel10k](https://github.com/romkatv/powerlevel10k) (no longer using)
Shell plugin manager | [Minzsh](https://github.com/bruhtus/dotfiles/blob/master/.config/zsh/minzsh)<br> [Zplug](https://github.com/zplug/zplug) (no longer using)
Package manager      | [Pacman](https://wiki.archlinux.org/title/pacman)<br> [Yay (AUR helper)](https://github.com/Jguer/yay)
Status bar           | [Polybar](https://github.com/polybar/polybar)
Notification daemon  | [Dunst](https://github.com/dunst-project/dunst)
Launcher             | [Rofi](https://github.com/davatorium/rofi)<br> [Dmenu](https://tools.suckless.org/dmenu/) (no longer using)
Compositor           | [Picom](https://github.com/yshui/picom) (no longer using)
File manager         | [Ranger (TUI)](https://github.com/ranger/ranger)<br> [Pcmanfm (GUI)](https://github.com/lxde/pcmanfm)
Video player         | [Mpv](https://mpv.io/)
System monitor       | [Htop](https://github.com/htop-dev/htop)<br> [Btop](https://github.com/aristocratos/btop)<br> [Bpytop](https://github.com/aristocratos/bpytop) (no longer using)<br> [Gtop](https://github.com/aksakalli/gtop) (no longer using)<br> [Conky](https://github.com/brndnmtthws/conky) (no longer using)
To-do list manager   | [Taskwarrior](https://taskwarrior.org/)
Python venv manager  | [Pyv](https://github.com/bruhtus/pyv)

</details>

## Resources
- [Download only vim config](https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/bruhtus/dotfiles/tree/master/.vim).
- [Atlassian tutorial](https://www.atlassian.com/git/tutorials/dotfiles).
- [Dotbare github repo](https://github.com/kazhala/dotbare).
- [Alacritty color schemes](https://github.com/alacritty/alacritty-theme).
- [Yanking in w3m](https://unix.stackexchange.com/questions/12497/yanking-urls-in-w3m).
- [Keycode/keysym for xorg or i3wm](http://xahlee.info/linux/linux_show_keycode_keysym.html).
- [Notification arch-based updates](https://eang.it/notifications-of-pacman-updates/).
