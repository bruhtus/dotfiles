# Personal Dotfiles

> Note to myself: don't forget to make the script executable by doing `chmod +x <filename>`

> To enable updates-notifier, use `systemctl --user enable --now updates-notifier.timer`

> Download only neovim config: [here](https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/bruhtus/dotfiles/tree/master/.config/nvim)

This repo is to backup my linux configuration so that I don't need to configure every new installation. I use [dotbare](https://github.com/kazhala/dotbare) to manage my dotfiles. Below is the simplified version to setup dotbare.

### Initialize dotbare to backup configuration dotfiles
```bash
dotbare finit
```

#### Example command
```bash
dotbare status
dotbare add .zshrc
dotbare commit -m 'Add zshrc'
dotbare push origin master
```

### To restore all of your dotfiles into new system
Install zsh first, and then do the instruction below:

- Install zplug with command below:
```sh
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
```
- After install zplug, add this to your `.zshrc`:
```sh
source $HOME/.config/zplug/init.zsh  # the default is in $HOME/.zplug/init.zsh
...
zplug "kazhala/dotbare"
...
zplug load
```
and then run `zplug install`.
- Reload the shell config (`source .zshrc` or `. .zshrc`).

#### Initialize dotbare in new system
```bash
dotbare finit -u <git-repo-url>
```

### References
- [Atlassian tutorial](https://www.atlassian.com/git/tutorials/dotfiles).
- [Dotbare github repo](https://github.com/kazhala/dotbare).
- [Alacritty color schemes](https://github.com/alacritty/alacritty/wiki/Color-schemes).
- [Alacritty preview color scheme](https://github.com/eendroroy/alacritty-theme).
- [Oh-my-zsh cheatsheet](https://github.com/ohmyzsh/ohmyzsh/wiki/Cheatsheet).
- [Yanking in w3m](https://unix.stackexchange.com/questions/12497/yanking-urls-in-w3m).
- [Keycode/keysym for xorg or i3wm](http://xahlee.info/linux/linux_show_keycode_keysym.html).
- [Zplug plugin manager](https://github.com/zplug/zplug).
- [Notification arch-based updates](https://eang.it/notifications-of-pacman-updates/)
