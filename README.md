# Personal Dotfiles

![setup-screenshot](https://raw.githubusercontent.com/wiki/bruhtus/dotfiles/arch-linux-setup-aug-2021.png)

This repo is to backup my linux configuration so that I don't need to re-configure every new installation. I use [dotbare](https://github.com/kazhala/dotbare) to manage my dotfiles. Below is the simplified version to setup dotbare.

## Initialize dotbare to backup config
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
> Note to myself: don't forget to make the script executable by doing `chmod +x <filename>`

> To enable updates-notifier, use `systemctl --user enable --now updates-notifier.timer`

Install zsh first, and then do the instruction below:

- Install zplug with command below:
```sh
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
```
- After zplug installed, add this to your `.zshrc`:
```sh
source $HOME/.config/zplug/init.zsh  # the default is in $HOME/.zplug/init.zsh
...
zplug "kazhala/dotbare"
...
zplug load
```
and then run `zplug install`.
- Reload the shell config (`source .zshrc` or `. .zshrc`).

### Initialize dotbare in new system
```sh
dotbare finit -u <git-repo-url>
```

<details>
<summary><strong>Some details about my setup</strong></summary>

Category            | Name
---                 | ---
Operating system    | [Arch linux](https://archlinux.org/)
Window manager      | [i3](https://github.com/i3/i3)
Text editor         | [Neovim](https://github.com/neovim/neovim)
Terminal emulator   | [Alacritty](https://github.com/alacritty/alacritty)
Shell               | [Zsh](https://zsh.sourceforge.io/Doc/Release/index.html) (interactive)
|                   | [Bash](https://www.gnu.org/software/bash/)
Shell prompt        | [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
Shell plugin manager| [Zplug](https://github.com/zplug/zplug)
Package manager     | [Pacman](https://wiki.archlinux.org/title/pacman)
|                   | [Yay (AUR helper)](https://github.com/Jguer/yay)
Status bar          | [Polybar](https://github.com/polybar/polybar)
Notification daemon | [Dunst](https://github.com/dunst-project/dunst)
Launcher            | [Rofi](https://github.com/davatorium/rofi)
|                   | [Dmenu](https://tools.suckless.org/dmenu/)
Compositor          | [Picom](https://github.com/yshui/picom)
File manager        | [Ranger (TUI)](https://github.com/ranger/ranger)
|                   | [Pcmanfm (GUI)](https://github.com/lxde/pcmanfm)
Video player        | [Mpv](https://mpv.io/)
System monitor      | [Htop](https://github.com/htop-dev/htop)
|                   | [Bpytop](https://github.com/aristocratos/bpytop)
|                   | [Conky](https://github.com/brndnmtthws/conky) (no longer using)
To-do list manager  | [Taskwarrior](https://taskwarrior.org/)
Python venv manager | [Pyv](https://github.com/bruhtus/pyv)

</details>

## Resources
- [Download only neovim config](https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/bruhtus/dotfiles/tree/master/.config/nvim).
- [Atlassian tutorial](https://www.atlassian.com/git/tutorials/dotfiles).
- [Dotbare github repo](https://github.com/kazhala/dotbare).
- [Alacritty color schemes](https://github.com/alacritty/alacritty/wiki/Color-schemes).
- [Alacritty preview color scheme](https://github.com/eendroroy/alacritty-theme).
- [Oh-my-zsh cheatsheet](https://github.com/ohmyzsh/ohmyzsh/wiki/Cheatsheet).
- [Yanking in w3m](https://unix.stackexchange.com/questions/12497/yanking-urls-in-w3m).
- [Keycode/keysym for xorg or i3wm](http://xahlee.info/linux/linux_show_keycode_keysym.html).
- [Zplug plugin manager](https://github.com/zplug/zplug).
- [Notification arch-based updates](https://eang.it/notifications-of-pacman-updates/).
