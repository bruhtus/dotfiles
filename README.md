# Personal Dotfiles

> “Simplicity is prerequisite for reliability.”<br>
> \- Edsger W. Dijkstra

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
Terminal emulator    | [st](https://st.suckless.org)<br> [Alacritty](https://github.com/alacritty/alacritty) (no longer using)
Terminal multiplexer | [Tmux](https://github.com/tmux/tmux)
Shell                | [Zsh](https://zsh.sourceforge.io/Doc/Release/index.html) (interactive)<br> [Bash](https://www.gnu.org/software/bash/)
Shell prompt         | [Custom zsh prompt](https://github.com/bruhtus/dotfiles/blob/master/.config/zsh/prompt)<br> [Starship](https://starship.rs/) (no longer using)<br> [Powerlevel10k](https://github.com/romkatv/powerlevel10k) (no longer using)
Shell plugin manager | [Minzsh](https://github.com/bruhtus/dotfiles/blob/master/.config/zsh/minzsh)<br> [Zplug](https://github.com/zplug/zplug) (no longer using)
Package manager      | [Pacman](https://wiki.archlinux.org/title/pacman)<br> [Yay (AUR helper)](https://github.com/Jguer/yay)
Status bar           | [i3bar](https://i3wm.org/i3bar/)<br> [Polybar](https://github.com/polybar/polybar) (no longer using)
Notification daemon  | [Dunst](https://github.com/dunst-project/dunst)
Launcher             | [Rofi](https://github.com/davatorium/rofi)<br> [Dmenu](https://tools.suckless.org/dmenu/) (no longer using)
Compositor           | [Picom](https://github.com/yshui/picom) (no longer using)
File manager         | [nnn (TUI)](https://github.com/jarun/nnn)<br> [Ranger (TUI)](https://github.com/ranger/ranger) (no longer using)<br> [Pcmanfm (GUI)](https://github.com/lxde/pcmanfm)
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
systemctl --user enable --now low-battery-notifier.timer
git config --file ~/.config/git/work user.email <work@example.com>
```

## Linux default application

Linux uses "MIME Types" to determine the type of a file (for example "image/jpeg")
and the Freedesktop Specifications (XDG) to determine which software should be used
for which MIME Type.

The "database" of associations between types and software is created by looking at
`mimeapps.list` files at several places (global configuration, your specific user
configuration, ...), and can be edited through the command line using xdg-mime.

Many softwares (your file explorer for example) will rely on xdg-open to open files,
which will query your preferences to know which software to start.

The `.desktop` in `mimeapps.list` file can also be seen and changed in
~/.local/share/applications

More info: https://wiki.archlinux.org/index.php/Xdg-utils

## Resources

- [Yanking in w3m](https://unix.stackexchange.com/questions/12497/yanking-urls-in-w3m).
- [Keycode/keysym for xorg or i3wm](http://xahlee.info/linux/linux_show_keycode_keysym.html).
- [Notification arch-based updates](https://eang.it/notifications-of-pacman-updates/).
- [Desktop entry
specification](https://specifications.freedesktop.org/desktop-entry-spec/latest/).
