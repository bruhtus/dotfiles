# Personal Dotfiles

![setup-screenshot](https://raw.githubusercontent.com/wiki/bruhtus/dotfiles/arch-linux-setup-march-2024.png)

This repo is to backup my linux configuration so that i don't need to
re-configure on every new installation.
I use [sdfm](.config/zsh/sdfm) to manage my dotfiles.

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

## Initialize dotfiles git repo using sdfm

We can use sdfm, which is a shell function that i created and
you can check on `.config/zsh/sdfm` in this git repo, to manage our dotfiles.

First, download the file using `wget` or `curl` like this:
```sh
wget https://raw.githubusercontent.com/bruhtus/dotfiles/master/.config/zsh/sdfm
```

And then source the file (assuming we are on the same directory as the
downloaded file):
```sh
. ./sdfm
```

After that, we can initialize new dotfiles repo using this command:
```sh
sdfi
```

The default dotfiles git repo is in "$HOME/.local/state/sdfm". To change the
default dotfiles git repo, we can use this command:
```sh
SDFM_GIT_DIR="$HOME/sdfm" sdfi
```

Don't forget to add the new $SDFM_GIT_DIR env variable into your shell
config or edit the sdfm file before sourcing the file.

To add a remote url, we can use this command:
```sh
sdfi -u <git-remote-url>
```

To add a file, we can use this command:
```sh
sdfa <file>
```

To commit the changes, we can use this command:
```sh
sdfc

# or
sdfc -m 'commit message'
```

To push the changes, we can use this command:
```sh
sdfp
```

To check the status of our dotfiles repo, we can use this command:
```sh
sdfs
```

## Restore this dotfiles in new system

Install zsh first, and then run the command below per line:
```sh
wget https://raw.githubusercontent.com/bruhtus/dotfiles/master/.config/zsh/sdfm
. ./sdfm
sdfi -u https://github.com/bruhtus/dotfiles.git -fa
systemctl --user enable --now updates-notifier.timer
```

## Resources

- [Download only vim config](https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/bruhtus/dotfiles/tree/master/.vim).
- [Atlassian tutorial](https://www.atlassian.com/git/tutorials/dotfiles).
- [Alacritty color schemes](https://github.com/alacritty/alacritty-theme).
- [Yanking in w3m](https://unix.stackexchange.com/questions/12497/yanking-urls-in-w3m).
- [Keycode/keysym for xorg or i3wm](http://xahlee.info/linux/linux_show_keycode_keysym.html).
- [Notification arch-based updates](https://eang.it/notifications-of-pacman-updates/).
